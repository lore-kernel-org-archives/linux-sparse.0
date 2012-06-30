From: KOSAKI Motohiro <kosaki.motohiro@gmail.com>
Subject: Re: [PATCH][RFC] handle -I and -include combination
Date: Sat, 30 Jun 2012 03:38:33 -0400
Message-ID: <4FEEACF9.4060701@gmail.com>
References: <1340023258-7069-1-git-send-email-kosaki.motohiro@gmail.com> <CANeU7Qm=0cCqHRJpDxeRK=QmqpJRyXu9wo1tKzCQqSxsQ_dLqQ@mail.gmail.com> <CAHGf_=oozZQZtyQow1GocS-=o8EiXctCP1HBa7Y7kMgCG58x6A@mail.gmail.com> <CANeU7QmVqaQVKEc-9O28J8Z5Hvy20DYffqVz7yHknoouHVC+fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:44437 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273Ab2F3Hij (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 30 Jun 2012 03:38:39 -0400
Received: by qadb17 with SMTP id b17so1092020qad.19
        for <linux-sparse@vger.kernel.org>; Sat, 30 Jun 2012 00:38:38 -0700 (PDT)
In-Reply-To: <CANeU7QmVqaQVKEc-9O28J8Z5Hvy20DYffqVz7yHknoouHVC+fQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: KOSAKI Motohiro <kosaki.motohiro@gmail.com>, linux-sparse@vger.kernel.org

(6/29/12 8:27 PM), Christopher Li wrote:
> On Wed, Jun 27, 2012 at 10:55 AM, KOSAKI Motohiro
> <kosaki.motohiro@gmail.com> wrote:
>> If I understand correctly, cmdline_include is only used from -includ=
e
>> and -imacro. and, -imacro is also needed to respect -I. Am I missing
>> something?
>=20
> Actually, I misread your patch. You patch function fine.
> The only thing I might change is the name of the "pre_buffer2".
> If this buffer is only use by the include files, we might just all it
> include_buffer or some thing like that. Let me know if you want to
> resend one with a better name, or I can patch it for you.
>=20
> Thanks for the patch. That will get rid of the static array as well.
> Nice.


Thanks. done.


=46rom e4f94099b1f01910cf2de10667c12cdf872a6522 Mon Sep 17 00:00:00 200=
1
=46rom: KOSAKI Motohiro <kosaki.motohiro@gmail.com>
Date: Mon, 18 Jun 2012 08:04:26 -0400
Subject: [PATCH] handle -I and -include combination

Currently, "-include" behavior is far different between sparse
and gcc. gcc can compile following testcase. but sparse can't.

This patch fixes it.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
 Makefile
 --------------
 bar:
    $(CC) -I./include-for-foo -include foo.h main.c -o bar

 main.c
 ------------------
 #include <stdio.h>
 int main(void)
 {
     printf("foo =3D %d=A5n", FOO);
     return 0;
 }

 include-for-foo/foo.h
 ----------------------
 #define FOO 42
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

Signed-off-by: KOSAKI Motohiro <kosaki.motohiro@gmail.com>
---
 lib.c |   52 ++++++++++++++++++++++++----------------------------
 lib.h |    9 ---------
 2 files changed, 24 insertions(+), 37 deletions(-)

diff --git a/lib.c b/lib.c
index 396e9f1..c698fa1 100644
--- a/lib.c
+++ b/lib.c
@@ -189,6 +189,8 @@ void die(const char *fmt, ...)
=20
 static struct token *pre_buffer_begin =3D NULL;
 static struct token *pre_buffer_end =3D NULL;
+static struct token *include_buffer_begin =3D NULL;
+static struct token *include_buffer_end =3D NULL;
=20
 int Waddress_space =3D 1;
 int Wbitwise =3D 0;
@@ -224,11 +226,6 @@ static enum { STANDARD_C89,
               STANDARD_GNU89,
               STANDARD_GNU99, } standard =3D STANDARD_GNU89;
=20
-#define CMDLINE_INCLUDE 20
-int cmdline_include_nr =3D 0;
-struct cmdline_include cmdline_include[CMDLINE_INCLUDE];
-
-
 void add_pre_buffer(const char *fmt, ...)
 {
 	va_list args;
@@ -247,6 +244,24 @@ void add_pre_buffer(const char *fmt, ...)
 	pre_buffer_end =3D end;
 }
=20
+void add_include_buffer(const char *fmt, ...)
+{
+	va_list args;
+	unsigned int size;
+	struct token *begin, *end;
+	char buffer[4096];
+
+	va_start(args, fmt);
+	size =3D vsnprintf(buffer, sizeof(buffer), fmt, args);
+	va_end(args);
+	begin =3D tokenize_buffer(buffer, size, &end);
+	if (!include_buffer_begin)
+		include_buffer_begin =3D begin;
+	if (include_buffer_end)
+		include_buffer_end->next =3D begin;
+	include_buffer_end =3D end;
+}
+
 static char **handle_switch_D(char *arg, char **next)
 {
 	const char *name =3D arg + 1;
@@ -299,16 +314,7 @@ static char **handle_switch_I(char *arg, char **ne=
xt)
=20
 static void add_cmdline_include(char *filename)
 {
-	int fd =3D open(filename, O_RDONLY);
-	if (fd < 0) {
-		perror(filename);
-		return;
-	}
-	if (cmdline_include_nr >=3D CMDLINE_INCLUDE)
-		die("too many include files for %s=A5n", filename);
-	cmdline_include[cmdline_include_nr].filename =3D filename;
-	cmdline_include[cmdline_include_nr].fd =3D fd;
-	cmdline_include_nr++;
+	add_include_buffer("#include =A5"%s=A5"=A5n", filename);
 }
=20
 static char **handle_switch_i(char *arg, char **next)
@@ -892,19 +898,9 @@ static struct symbol_list *sparse_file(const char =
*filename)
  */
 static struct symbol_list *sparse_initial(void)
 {
-	struct token *token;
-	int i;
-
-	// Prepend any "include" file to the stream.
-	// We're in global scope, it will affect all files!
-	token =3D NULL;
-	for (i =3D cmdline_include_nr - 1; i >=3D 0; i--)
-		token =3D tokenize(cmdline_include[i].filename, cmdline_include[i].f=
d,
-				 token, includepath);
-
-	// Prepend the initial built-in stream
-	if (token)
-		pre_buffer_end->next =3D token;
+	if (include_buffer_begin)
+		pre_buffer_end->next =3D include_buffer_begin;
+
 	return sparse_tokenstream(pre_buffer_begin);
 }
=20
diff --git a/lib.h b/lib.h
index 2cea252..ee954fe 100644
--- a/lib.h
+++ b/lib.h
@@ -41,15 +41,6 @@ struct position {
 		     noexpand:1;
 };
=20
-struct cmdline_include {
-	char *filename;
-	int fd;
-};
-
-extern struct cmdline_include cmdline_include[];
-extern int cmdline_include_nr;
-
