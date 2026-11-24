ClearAll[cookieFindings, cookieRiskScore, riskLevel, auditCookies, alternativeSuggestions];

sampleCookies = {
  <|"Name" -> "session_id", "Domain" -> "shop.example", "Secure" -> True, "HTTPOnly" -> True, "SameSite" -> "Lax", "ThirdParty" -> False, "LifetimeDays" -> 0|>,
  <|"Name" -> "preferences", "Domain" -> "shop.example", "Secure" -> True, "HTTPOnly" -> False, "SameSite" -> "Lax", "ThirdParty" -> False, "LifetimeDays" -> 400|>,
  <|"Name" -> "analytics_id", "Domain" -> "stats.example", "Secure" -> False, "HTTPOnly" -> False, "SameSite" -> "None", "ThirdParty" -> True, "LifetimeDays" -> 730|>,
  <|"Name" -> "ad_tracker", "Domain" -> "ads.example", "Secure" -> False, "HTTPOnly" -> False, "SameSite" -> "None", "ThirdParty" -> True, "LifetimeDays" -> 3650|>,
  <|"Name" -> "login_state", "Domain" -> "accounts.example", "Secure" -> True, "HTTPOnly" -> True, "SameSite" -> "Strict", "ThirdParty" -> False, "LifetimeDays" -> 30|>
};

cookieFindings[cookie_Association] := DeleteCases[
  {
    If[!TrueQ[Lookup[cookie, "Secure", False]], "The cookie is not marked Secure.", Nothing],
    If[!TrueQ[Lookup[cookie, "HTTPOnly", False]], "JavaScript may be able to read this cookie. Use HTTPOnly when the site does not need script access.", Nothing],
    If[!MemberQ[{"Lax", "Strict"}, Lookup[cookie, "SameSite", "Missing"]], "Review the SameSite setting. Lax or Strict may be suitable, depending on the site.", Nothing],
    If[TrueQ[Lookup[cookie, "ThirdParty", False]], "This cookie is set by a third party. Check whether it is needed.", Nothing],
    If[TrueQ[Lookup[cookie, "LifetimeDays", 0] > 365], "The cookie lasts longer than one year. Consider a shorter lifetime.", Nothing]
  },
  Nothing
];

cookieRiskScore[cookie_Association] := Min[
  100,
  25 Boole[!TrueQ[Lookup[cookie, "Secure", False]]] +
  20 Boole[!TrueQ[Lookup[cookie, "HTTPOnly", False]]] +
  15 Boole[!MemberQ[{"Lax", "Strict"}, Lookup[cookie, "SameSite", "Missing"]]] +
  20 Boole[TrueQ[Lookup[cookie, "ThirdParty", False]]] +
  20 Boole[TrueQ[Lookup[cookie, "LifetimeDays", 0] > 365]
];

riskLevel[score_Integer] := Which[
  score >= 60, "High",
  score >= 30, "Review",
  True, "Low"
];

auditCookies[cookies_List] := Map[
  Function[cookie,
    With[{score = cookieRiskScore[cookie]},
      Join[
        cookie,
        <|
          "RiskScore" -> score,
          "RiskLevel" -> riskLevel[score],
          "Findings" -> cookieFindings[cookie]
        |>
      ]
    ]
  ],
  cookies
];

softwareAlternatives = {
  <|"Category" -> "Browser", "CurrentChoice" -> "Google Chrome", "Alternative" -> "Mozilla Firefox", "Reason" -> "Its tracking protection can block many known trackers. Check the settings that fit your browsing habits."|>,
  <|"Category" -> "Search", "CurrentChoice" -> "Google Search", "Alternative" -> "DuckDuckGo", "Reason" -> "It offers a search option designed to reduce personal search profiling. Review its current privacy policy."|>,
  <|"Category" -> "Password manager", "CurrentChoice" -> "A hosted password manager", "Alternative" -> "KeePassXC", "Reason" -> "The encrypted vault stays in a file you control. You are responsible for backups and safe syncing."|>,
  <|"Category" -> "Website analytics", "CurrentChoice" -> "A third party analytics service", "Alternative" -> "Matomo, self hosted", "Reason" -> "A self hosted setup gives the site owner more control over where analytics data is stored. Configuration still matters."|>
};

alternativeSuggestions[category_String] := Dataset @ Select[
  softwareAlternatives,
  ToLowerCase[#["Category"]] === ToLowerCase[category] &
];

auditResults = auditCookies[sampleCookies];
riskCounts = Counts[Lookup[auditResults, "RiskLevel"]];

Print["Cookie audit"];
Print[Dataset[auditResults]];

Print["Risk summary"];
Print[
  BarChart[
    Lookup[riskCounts, {"Low", "Review", "High"}, 0],
    ChartLabels -> {"Low", "Review", "High"},
    Frame -> True,
    FrameLabel -> {None, "Number of cookies"},
    PlotLabel -> "Findings by risk level",
    ImageSize -> Large
  ]
];

Print["Example password manager alternative"];
Print[alternativeSuggestions["Password manager"]];
