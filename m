From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/4] Add support for '-vdata', the equivalent of '-ventry' but for data
Date: Sun,  1 Feb 2015 03:19:43 +0100
Message-ID: <1422757186-8007-2-git-send-email-luc.vanoostenryck@gmail.com>
References: <CANeU7QnQWRRB1kmt7KOjuJ4PFasefaX91yPZ-DEYxE2qUzxX3A@mail.gmail.com>
 <1422757186-8007-1-git-send-email-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:59844 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334AbbBACUb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 31 Jan 2015 21:20:31 -0500
Received: by mail-wi0-f177.google.com with SMTP id r20so9111401wiv.4
        for <linux-sparse@vger.kernel.org>; Sat, 31 Jan 2015 18:20:30 -0800 (PST)
In-Reply-To: <1422757186-8007-1-git-send-email-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org, linux@rasmusvillemoes.dk, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 2 ++
 lib.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/lib.c b/lib.c
index 8dc5bcf9..73714109 100644
--- a/lib.c
+++ b/lib.c
@@ -243,6 +243,7 @@ int Wuninitialized = 1;
 int Wvla = 1;
 
 int dbg_entry = 0;
+int dbg_data = 0;
 int dbg_dead = 0;
 
 int preprocess_only;
@@ -517,6 +518,7 @@ static char **handle_switch_W(char *arg, char **next)
 
 static struct warning debugs[] = {
 	{ "entry", &dbg_entry},
+	{ "data", &dbg_data},
 	{ "dead", &dbg_dead},
 };
 
diff --git a/lib.h b/lib.h
index 15b69fa2..2e1170b4 100644
--- a/lib.h
+++ b/lib.h
@@ -129,6 +129,7 @@ extern int Wuninitialized;
 extern int Wvla;
 
 extern int dbg_entry;
+extern int dbg_data;
 extern int dbg_dead;
 
 extern int arch_m64;
-- 
2.2.0

