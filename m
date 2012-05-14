From: Christopher Li <sparse@chrisli.org>
Subject: Re: Fwd: dependency tee from c parser entities downto token
Date: Mon, 14 May 2012 03:53:35 -0700
Message-ID: <CANeU7Q=dekYJXU-LKv0R6_ty-u23yJjV-gzE5Et+7u+SMkDSTg@mail.gmail.com>
References: <4F967865.60809@gaisler.com>
	<CANeU7QkJJx6A8zfZY9YRJ3GP-msxb3yjQpEO08RbNKE9asPTPA@mail.gmail.com>
	<4FA5B9E8.7010208@gmail.com>
	<CANeU7Qm-M7u0h6MswEMw3KZ7wxaxiikpChXJAuhkV0EzcHkH9A@mail.gmail.com>
	<4FA767BD.8060703@gaisler.com>
	<CANeU7Q=nHs+f1wKVM0bGDc-uxubBztPxXjiMvDRpph4RJWPHYg@mail.gmail.com>
	<4FA8BF7D.60606@gaisler.com>
	<CANeU7QkLrr1p8-Bofx9fnZ82BA2pc7sOxSOa-zim5NhWHXTNQA@mail.gmail.com>
	<4FAA3D50.8080901@gaisler.com>
	<CANeU7Q=mq1FsGViTp7L-83Wns6uDLcRKi7usNRiO1D3Ox_Dmww@mail.gmail.com>
	<4FAB5DEA.5060009@gaisler.com>
	<4FAB6268.7070908@gaisler.com>
	<CANeU7Qk-DTs+WL=u2g5WQ1L2J++ZBkCHi8_85bmUWto7rq0-9Q@mail.gmail.com>
	<4FAB8F9E.8040205@gaisler.com>
	<CANeU7QnnXk26ybnayuRZ2ZGSArMt1Bne4KGXxt+0d7tBjN=6Kw@mail.gmail.com>
	<4FABB132.1070308@gmail.com>
	<4FABB467.7030703@gmail.com>
	<CANeU7Q=_uqwk+ePbErQ9gsX3x945_gATUZ_mJeYuTo2SoYhCpQ@mail.gmail.com>
	<4FAD892B.8070709@gmail.com>
	<CANeU7QnEyUExcxaoVEeamhu1m+Z_pg0TpKBP00hh+gyPgdq66w@mail.gmail.com>
	<4FAEA208.3090601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59505 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755880Ab2ENKxg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 14 May 2012 06:53:36 -0400
Received: by yhmm54 with SMTP id m54so4033209yhm.19
        for <linux-sparse@vger.kernel.org>; Mon, 14 May 2012 03:53:35 -0700 (PDT)
In-Reply-To: <4FAEA208.3090601@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Konrad Eisele <eiselekd@gmail.com>
Cc: Konrad Eisele <konrad@gaisler.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, May 12, 2012 at 10:46 AM, Konrad Eisele <eiselekd@gmail.com> wrote:
> Appended is a test-patch that adds test-mdep testcase.
> The file mdep.c is used to record that macro
> expansion, each token will have a reference to its
> source.
> test-mdep.c does pre-process (as test-macro.c) then
> prints out the token trace through macros for each
> token: @{ } is used to mark the active path.

Here is some feed back for the patch you send out:

>diff --git a/a.h b/a.h
>new file mode 100644

The test file should be in validation/ directory. Please give a.h a
name represent the test as well.

+               if (!strncmp(arg, "buildin", 7)) {
+                       fnobuildin = 1;
+               }

Is there a stand gcc option to handle nobuildin? I haven't found one.
If gcc has one, we can duplicate the gcc behavior. Otherwise,
I don't see it is necessary to add one. The dependence program needs
to able to handle the symbol from built in stream any way.
If it is for easier to debug, your program can trivially skip out the builtin.
stream.

+ * BSD-License
+ * Redistribution and use in source and binary forms are permitted

Can you make it cover by the sparse license file as well? I don't mind you grant
extra license to your code. But please at least make it cover by the
license of the project itself otherwise I won't apply it. It is pure overhead
to figure out what license is compatiable to spase and maintain different
file at different license. Have all file under the project cover by the same
license will keep it simple.

+void mdep_init(void) {
+    preprocess_hook = &pp;
+    pps = init_stream("<pp>", -1, 0);
+}

Please use the same coding standing as the other part of the project.
It is actually the same as linux kernel. The "{" for the function should be
on a new line. Indentation is tab and 8 char wide. There is a lot of those
little one on this file. I am not going to repeat myself here.

+struct hash {
+    struct hash_v *f;
+} h[HASH_LEN];

+struct pp {
+    enum pp_typ t;
+    union {
+        unsigned int argi;
+    };
+    struct pp_e *f;
+    struct symbol *sym;
+    struct token *tok;
+    struct token *s, *d;
+};
+

I hate those one letter member name. You have to guess what it is
all the time. pp_dope_list() is full of those one letter variable name as
well, make it very hard to read. The variable name need to be a little
bit more meaningful.


+       show_tokenstream(token, 0);
Please don't use 0 for NULL pointer.

-void show_tokenstream(struct token *token)
+void show_tokenstream(struct token *token, struct token *end)
-       while (!eof_token(token)) {
+       while (token != end && !eof_token(token)) {

I don't see you use the show_tokenstream with two arguments.
You write your own show_tokenstream for mdep any way.
You can leave it one unchanged.

@@ -194,7 +196,7 @@ void show_tokenstream(struct token *token)
-               printf("%s%.*s", show_token(token), prec, separator);
+               fprintf(stderr,"%s%.*s", show_token(token), prec, separator);

Can't do that, the "-E" will use show_tokenstream() as well. You just
change it to stderr for "-E".


To be continue...

Chris
