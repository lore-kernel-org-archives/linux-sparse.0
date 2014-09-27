From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] sparse: Make -Werror turn warnigns into errors
Date: Sat, 27 Sep 2014 08:24:42 +0800
Message-ID: <CANeU7QnM-sns1pOgjpOrKp2LkMnf7O=89XSvF7hCuzvrwg5bPw@mail.gmail.com>
References: <795aaa7448d91bd59bcbea3d8e49b068a569409e.1411632579.git.tgraf@suug.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:49345 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756020AbaI0AYn (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 26 Sep 2014 20:24:43 -0400
Received: by mail-we0-f170.google.com with SMTP id q58so884651wes.29
        for <linux-sparse@vger.kernel.org>; Fri, 26 Sep 2014 17:24:42 -0700 (PDT)
In-Reply-To: <795aaa7448d91bd59bcbea3d8e49b068a569409e.1411632579.git.tgraf@suug.ch>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Graf <tgraf@suug.ch>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Sep 25, 2014 at 4:11 PM, Thomas Graf <tgraf@suug.ch> wrote:
>
> @@ -467,6 +475,9 @@ static char **handle_onoff_switch(char *arg, char **next, const struct warning w
>                 }
>         }
>
> +       if (!strcmp(p, "error"))
> +               Werror = 1;
> +
>         // Prefixes "no" and "no-" mean to turn warning off.
>         if (p[0] == 'n' && p[1] == 'o') {
>                 p += 2;
> diff --git a/lib.h b/lib.h
> index f6cd9b4..dc01684 100644

While I apply the patch, I notice this piece. Sparse has the on/off switch list.
"Werror" seems should belong to that list. Gcc accept "-Wno-error" to turn off
the switch. However, we might not want "-Wsparse-all" to turn on "Werror".

So I have the incremental patch to convert "Werror" using the on/off
switch list.

Feed back?

Chris

diff --git a/lib.c b/lib.c
index 5203d98..8395662 100644
--- a/lib.c
+++ b/lib.c
@@ -439,6 +439,7 @@ static const struct warning {
        { "designated-init", &Wdesignated_init },
        { "do-while", &Wdo_while },
        { "enum-mismatch", &Wenum_mismatch },
+       { "error", &Werror },
        { "init-cstring", &Winit_cstring },
        { "non-pointer-null", &Wnon_pointer_null },
        { "old-initializer", &Wold_initializer },
@@ -470,14 +471,11 @@ static char **handle_onoff_switch(char *arg,
char **next, const struct warning

        if (!strcmp(p, "sparse-all")) {
                for (i = 0; i < n; i++) {
-                       if (*warnings[i].flag != WARNING_FORCE_OFF)
+                       if (*warnings[i].flag != WARNING_FORCE_OFF &&
warnings[i].flag != &Werror)
                                *warnings[i].flag = WARNING_ON;
                }
        }

-       if (!strcmp(p, "error"))
-               Werror = 1;
