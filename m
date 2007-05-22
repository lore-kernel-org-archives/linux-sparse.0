From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 3/5] Add (more) support for WIN32 attribute names
Date: Tue, 22 May 2007 19:00:53 +0100
Message-ID: <46532FD5.6000307@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from anchor-fallback-95.mail.demon.net ([194.217.242.82]:34719 "EHLO
	anchor-fallback-95.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758147AbXEVTOF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 15:14:05 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:4065 "EHLO
	anchor-post-34.mail.demon.net") by anchor-fallback-95.mail.demon.net
	with ESMTP id S816619AbXEVSRT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 18:17:19 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


In particular, the following identifiers (along with their __X__ variants)
are now accepted as attribute names: fastcall, dllimport and dllexport.
(cdecl and stdcall were added in baf2c5a84e by Michael Stefaniuc).
For now, at least, these attributes are just ignored.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
  ident-list.h |    7 +++++++
  parse.c      |    6 ++++++
  2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/ident-list.h b/ident-list.h
index 7633a2f..d09c2ab 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -70,6 +70,13 @@ IDENT(nonnull); IDENT(__nonnull); IDENT(__nonnull__);
  IDENT(__deprecated__);
  IDENT(__warn_unused_result__);

+/* WIN32 specific Attribute names */
+IDENT(cdecl); IDENT(__cdecl__);
+IDENT(stdcall); IDENT(__stdcall__);
+IDENT(fastcall); IDENT(__fastcall__);
+IDENT(dllimport); IDENT(__dllimport__);
+IDENT(dllexport); IDENT(__dllexport__);
+
  /* Preprocessor idents */
  __IDENT(pragma_ident, "__pragma__", 0);
  __IDENT(__VA_ARGS___ident, "__VA_ARGS__", 0);
diff --git a/parse.c b/parse.c
index b74c7c0..db5c9e6 100644
--- a/parse.c
+++ b/parse.c
@@ -327,6 +327,12 @@ static struct init_keyword {
  	{ "__cdecl__",	NS_KEYWORD,	.op = &ignore_attr_op },
  	{ "stdcall",	NS_KEYWORD,	.op = &ignore_attr_op },
  	{ "__stdcall__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "fastcall",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__fastcall__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "dllimport",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__dllimport__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "dllexport",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__dllexport__",	NS_KEYWORD,	.op = &ignore_attr_op },
  };

  void init_parser(int stream)
-- 
1.5.1
