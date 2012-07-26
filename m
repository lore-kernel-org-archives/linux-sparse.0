From: Christopher Li <sparse@chrisli.org>
Subject: Re: Adding default for m64/m32 handle
Date: Thu, 26 Jul 2012 03:28:26 -0700
Message-ID: <CANeU7Qk_V12Db0a2HD9nQEfMD-i-xE84kc1T4-H+xM2SBAMSyg@mail.gmail.com>
References: <20120726074554.GM4403@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:65333 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab2GZK22 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 26 Jul 2012 06:28:28 -0400
Received: by lbbgm6 with SMTP id gm6so1358191lbb.19
        for <linux-sparse@vger.kernel.org>; Thu, 26 Jul 2012 03:28:26 -0700 (PDT)
In-Reply-To: <20120726074554.GM4403@mwanda>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-sparse@vger.kernel.org

On Thu, Jul 26, 2012 at 12:45 AM, Dan Carpenter
<dan.carpenter@oracle.com> wrote:
> Hi Chris,
>
> The patch 7aa79f8401f0 "Adding default for m64/m32 handle" causes
> a problem for variables called x86_64.
>
> $ echo "unsigned char x86_64;" > test.c
> $ ./sparse test.c
> test.c:1:15: warning: missing identifier in declaration
> test.c:1:15: error: Expected ; at the end of type declaration
> test.c:1:15: error: got 1

Are you suggesting we do some thing like this patch to remove the
define of x86_64?
Gcc does not seem to define x86_64.

Any objections?

Chris

diff --git a/lib.c b/lib.c
index b4d3944..bb814f2 100644
--- a/lib.c
+++ b/lib.c
@@ -372,8 +372,6 @@ static void handle_arch_m64_finalize(void)
                size_t_ctype = &ulong_ctype;
                ssize_t_ctype = &long_ctype;
 #ifdef __x86_64__
-               add_pre_buffer("#weak_define x86_64 1\n");
-               add_pre_buffer("#weak_define __x86_64 1\n");
                add_pre_buffer("#weak_define __x86_64__ 1\n");
 #endif
        }
