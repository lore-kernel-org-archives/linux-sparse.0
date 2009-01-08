From: Hannes Eder <hannes@hanneseder.net>
Subject: [PATCH] refactor handle_switch_f
Date: Thu, 08 Jan 2009 21:50:56 +0100
Message-ID: <20090108204937.6511.56533.stgit@vmbox.hanneseder.net>
References: <70318cbf0901081213i22dc8054yda4230e8a6375e9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:59377 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbZAHUvC (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 8 Jan 2009 15:51:02 -0500
Received: by bwz14 with SMTP id 14so27986213bwz.13
        for <linux-sparse@vger.kernel.org>; Thu, 08 Jan 2009 12:50:59 -0800 (PST)
In-Reply-To: <70318cbf0901081213i22dc8054yda4230e8a6375e9a@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Alexey Zaytsev <alexey.zaytsev@gmail.com>, Junio C Hamano <junio@pobox.com>

This also fixes a possible source of bugs in parsing other
-f<whatever> options, i.e. -ftabstop=foo would set the option -ffoo.

Signed-off-by: Hannes Eder <hannes@hanneseder.net>
---

On Thu, Jan 8, 2009 at 9:13 PM, Christopher Li <sparse@chrisli.org> wrote:
> Is that the only portion that get changed between v2 and v3?
> It took me a while to realized what really get changed here.

Yes, only handle_switch_f has changed between v2 and v3.

> I suggest a new function: handle_switch_ftabstop() here.
>
> Then we do:
>
>       if (!strncmp(arg, "tabstop=", 8))
>           return handle_switch_ftabstop(arg+8, next);
>
> It will make handle_switch_f cleaner.

Good idea.

> I already apply your V2 patch. Can you make this change
> an incremental patch against my tree?

Here we go.

 lib.c |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/lib.c b/lib.c
index be9e8d7..54d8cf5 100644
--- a/lib.c
+++ b/lib.c
@@ -524,25 +524,34 @@ static char **handle_switch_O(char *arg, char **next)
 	return next;
 }
 
+static char **handle_switch_ftabstop(char *arg, char **next)
+{
+	char *end;
+	unsigned long val;
+
+	if (*arg == '\0')
+		die("error: missing argument to \"-ftabstop=\"");
+
+	/* we silently ignore silly values */
+	val = strtoul(arg, &end, 10);
+	if (*end == '\0' && 1 <= val && val <= 100)
+		tabstop = val;
+
+	return next;
+}
+
 static char **handle_switch_f(char *arg, char **next)
 {
 	int flag = 1;
 
 	arg++;
 
-	if (!strncmp(arg, "tabstop=", 8)) {
-		char *end;
-		unsigned long val;
-		arg += 8;
+	if (!strncmp(arg, "tabstop=", 8))
+		return handle_switch_ftabstop(arg+8, next);
 
-		if (*arg == '\0')
-			die("error: missing argument to \"-ftabstop=\"");
+	/* handle switches w/ arguments above, boolean and only boolean below */
 
-		/* we silently ignore silly values */
-		val = strtoul(arg, &end, 10);
-		if (*end == '\0' && 1 <= val && val <= 100)
-			tabstop = val;
-	} else if (!strncmp(arg, "no-", 3)) {
+	if (!strncmp(arg, "no-", 3)) {
 		flag = 0;
 		arg += 3;
 	}

