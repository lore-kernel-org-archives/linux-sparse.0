Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256425;
	b=uDuztJgD2CdLTKlOEzn+lJkHwyWZN3PM72RSCTudPjTMf81Krb+0aPQECtBNx22vzA/G
	 yiKWaHhKdYiPiGcOdrVEkOVXsjnY8DM6wqdZirL1lg6JpyuK/qsC8WFc5MuBaNodWHmXC
	 yeQFFg79Xa32gfd7lVqnppNrqDqwDXgQjYGwOMo64+TTwjn7A2TH3YkLe51VLNDqmWXbg
	 8ys3saAwa0DgqVOC+lxR+WhY60K775xNcUepVg0wNTBbn9TzGmX2cojx8Ank9vJPA/3LW
	 92Hk9SCQMeZDKRcIbQu1cXBmf7VFVGUqC6gypToxMyc0G1VnJKzGgIe2etJ2nDpNrQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=P5I0y69SjPaIGfV8GS070LPm71K++pmp6uSnor1nIaE=;
	b=WFzdm/mcOD+tVNM6VvV8UKtlzoQ9M1TYGvde6eVcv5Qvi1BqjeNHnZoOiwfDZeXV8WMV
	 OZzKqDWsH9b+bvLjdWUj9VQ036/Q/2Dgq6KZbcHRRURZMldTYe5z/kAQxfblnzGuAATUT
	 PFVO+gS5+mCfWJuIK4ZIV+cLkYYnvDQyWj3j2D9yNefPBSMkHvPLhq0ZOTsEoF/Dexo6O
	 Uqf1zXyMd3x1ITcPcwlBghgwloPfe1bbD1U8joKfl3/rFaNlAr1V4UHxagYYCwYLlQE1i
	 EFg3+PGVlJaDLvoqWL5XZsSYJ0pGMk8T2rKyBYuA+zEpf07Itll1P2y0HeVCee7ex/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=e95jWcHF;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3E6606A31C
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A3E6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=e95jWcHF
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM75dRfz1XMYJT;
	Mon,  9 Nov 2026 20:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256415; x=1796848416; bh=P5I0y
	69SjPaIGfV8GS070LPm71K++pmp6uSnor1nIaE=; b=e95jWcHFbxSqFrtg6iN69
	2hIw7Jn0+D1dPNipUoJmHyUXKFNugYbQ4pIb+837xPqUfQJhWN7vBItmSxOpuT29
	Mn3P84cThfhEFE6t+QXRZfrXIpccPh6LP4TZqzuJ8V/CHbvVU4Ke70Wn6IRErfk9
	26PKE+VO5TRlpiZc+nVeRi9EEyD1T4oCwO7xYbzcal72V+i/gz3TfQEENnYXuRxo
	Q22T0k8SliM9Y/N5ATcgWSxku450efO4HLrybfR8vWlDZf//QDxQsn0om81wklWm
	v2fs6WBCVgPkVCwg5KiKDLTjOGJbAkrunGUN67h7X+s5wHuwNv2DvY+OprT21Bg4
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 579NDESa11ls; Mon,  9 Nov 2026 20:33:35 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM05YB7z1XMYJL;
	Mon,  9 Nov 2026 20:33:32 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 38/73] clang-format: Add .clang-format configuration file
Date: Mon,  9 Nov 2026 12:32:24 -0800
Message-ID: <20261109203259.362845-39-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109203259.362845-1-bvanassche@acm.org>
References: <20261109203259.362845-1-bvanassche@acm.org>
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a .clang-format configuration file matching the sparse coding style
(8-column tabs for indentation, 80-column line limit, Linux kernel brace
and pointer alignment conventions, and foreach macro definitions) so
that code formatting can be checked and applied consistently.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 .clang-format | 125 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)
 create mode 100644 .clang-format

diff --git a/.clang-format b/.clang-format
new file mode 100644
index 000000000000..6390eb565a75
--- /dev/null
+++ b/.clang-format
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: MIT
+#
+# clang-format configuration file. Intended for clang-format >=3D 11.
+#
+# For more information, see:
+#
+#   https://clang.llvm.org/docs/ClangFormat.html
+#   https://clang.llvm.org/docs/ClangFormatStyleOptions.html
+#
+---
+AccessModifierOffset: -4
+AlignAfterOpenBracket: Align
+AlignConsecutiveAssignments: false
+AlignConsecutiveDeclarations: false
+AlignEscapedNewlines: Left
+AlignOperands: true
+AlignTrailingComments: false
+AllowAllParametersOfDeclarationOnNextLine: false
+AllowShortBlocksOnASingleLine: false
+AllowShortCaseLabelsOnASingleLine: false
+AllowShortFunctionsOnASingleLine: None
+AllowShortIfStatementsOnASingleLine: false
+AllowShortLoopsOnASingleLine: false
+AlwaysBreakAfterDefinitionReturnType: None
+AlwaysBreakAfterReturnType: None
+AlwaysBreakBeforeMultilineStrings: false
+AlwaysBreakTemplateDeclarations: false
+BinPackArguments: true
+BinPackParameters: true
+BraceWrapping:
+  AfterClass: false
+  AfterControlStatement: false
+  AfterEnum: false
+  AfterFunction: true
+  AfterNamespace: true
+  AfterObjCDeclaration: false
+  AfterStruct: false
+  AfterUnion: false
+  AfterExternBlock: false
+  BeforeCatch: false
+  BeforeElse: false
+  IndentBraces: false
+  SplitEmptyFunction: true
+  SplitEmptyRecord: true
+  SplitEmptyNamespace: true
+BreakBeforeBinaryOperators: None
+BreakBeforeBraces: Custom
+BreakBeforeInheritanceComma: false
+BreakBeforeTernaryOperators: false
+BreakConstructorInitializersBeforeComma: false
+BreakConstructorInitializers: BeforeComma
+BreakAfterJavaFieldAnnotations: false
+BreakStringLiterals: false
+ColumnLimit: 80
+CommentPragmas: '^ IWYU pragma:'
+CompactNamespaces: false
+ConstructorInitializerAllOnOneLineOrOnePerLine: false
+ConstructorInitializerIndentWidth: 8
+ContinuationIndentWidth: 8
+Cpp11BracedListStyle: false
+DerivePointerAlignment: false
+DisableFormat: false
+ExperimentalAutoDetectBinPacking: false
+FixNamespaceComments: false
+ForEachMacros:
+  - 'FOR_EACH_PTR'
+  - 'FOR_EACH_PTR_NOTAG'
+  - 'FOR_EACH_PTR_REVERSE'
+  - 'FOR_EACH_PTR_REVERSE_TAG'
+  - 'FOR_EACH_PTR_TAG'
+  - 'RECURSE_PTR_REVERSE'
+
+IncludeBlocks: Preserve
+IncludeCategories:
+  - Regex: '.*'
+    Priority: 1
+IncludeIsMainRegex: '(Test)?$'
+IndentCaseLabels: false
+IndentGotoLabels: false
+IndentPPDirectives: None
+IndentWidth: 8
+IndentWrappedFunctionNames: false
+JavaScriptQuotes: Leave
+JavaScriptWrapImports: true
+KeepEmptyLinesAtTheStartOfBlocks: false
+MacroBlockBegin: ''
+MacroBlockEnd: ''
+MaxEmptyLinesToKeep: 1
+NamespaceIndentation: None
+ObjCBinPackProtocolList: Auto
+ObjCBlockIndentWidth: 8
+ObjCSpaceAfterProperty: true
+ObjCSpaceBeforeProtocolList: true
+
+# Taken from git's rules
+PenaltyBreakAssignment: 10
+PenaltyBreakBeforeFirstCallParameter: 30
+PenaltyBreakComment: 10
+PenaltyBreakFirstLessLess: 0
+PenaltyBreakString: 10
+PenaltyExcessCharacter: 100
+PenaltyReturnTypeOnItsOwnLine: 60
+
+PointerAlignment: Right
+ReflowComments: false
+SortIncludes: false
+SortUsingDeclarations: false
+SpaceAfterCStyleCast: false
+SpaceAfterTemplateKeyword: true
+SpaceBeforeAssignmentOperators: true
+SpaceBeforeCtorInitializerColon: true
+SpaceBeforeInheritanceColon: true
+SpaceBeforeParens: ControlStatementsExceptForEachMacros
+SpaceBeforeRangeBasedForLoopColon: true
+SpaceInEmptyParentheses: false
+SpacesBeforeTrailingComments: 1
+SpacesInAngles: false
+SpacesInContainerLiterals: false
+SpacesInCStyleCastParentheses: false
+SpacesInParentheses: false
+SpacesInSquareBrackets: false
+Standard: Cpp03
+TabWidth: 8
+UseTab: Always
+...
