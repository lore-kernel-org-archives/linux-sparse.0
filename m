From: Bernd Petrovitsch <bernd@sysprog.at>
Subject: [[PATCH]] Fix a typo - "typdef" is neither C nor plain English
Date: Fri, 20 Aug 2010 12:36:38 +0200
Message-ID: <1282304949.10440.234.camel@thorin>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:3302 "EHLO
	esgaroth.petrovitsch.priv.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752418Ab0HTLtK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 20 Aug 2010 07:49:10 -0400
Received: from [172.16.0.10] (chello062178036229.13.11.wu-wien.teleweb.at [62.178.36.229])
	(authenticated bits=0)
	by esgaroth.petrovitsch.priv.at (8.14.1/8.14.1) with ESMTP id o7KBn8Za022993
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Fri, 20 Aug 2010 13:49:09 +0200
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Signed-off-by: Bernd Petrovitsch <bernd@sysprog.at>
---
 show-parse.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/show-parse.c b/show-parse.c
index 99795e8..b771018 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -100,7 +100,7 @@ const char *modifier_string(unsigned long mod)
 		"auto", "register", "static", "extern",
 		"const", "volatile", "[signed]", "[unsigned]",
 		"[char]", "[short]", "[long]", "[long long]",
-		"[typdef]", "[structof]", "[unionof]", "[enum]",
+		"[typedef]", "[structof]", "[unionof]", "[enum]",
 		"[typeof]", "[attribute]", "inline", "[addressable]",
 		"[nocast]", "[noderef]", "[accessed]", "[toplevel]",
 		"[label]", "[assigned]", "[type]", "[safe]",
-- 
1.7.2.1

