From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 06/10] don't run sparse{c,i} tests when sparse-llvm is disabled
Date: Thu, 2 Oct 2014 11:44:56 +0800
Message-ID: <CANeU7QnXWFad9Re0MtGkei6F6ZnUOH96et5_7aJQommFp2dLwQ@mail.gmail.com>
References: <53DFD320.2050903@ramsay1.demon.co.uk>
	<CANeU7QkFPTW04ECjrJKHO51g38R6r3Rt8jX74PsAnEgpxRqxYw@mail.gmail.com>
	<5426BD97.2080700@ramsay1.demon.co.uk>
	<CANeU7Q=vDAuBwWqy0=rbvkpgmzysCw=pfSEcwzyRRSZj3QrJbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33356 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667AbaJBDo5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 1 Oct 2014 23:44:57 -0400
Received: by mail-wi0-f179.google.com with SMTP id d1so2677571wiv.6
        for <linux-sparse@vger.kernel.org>; Wed, 01 Oct 2014 20:44:56 -0700 (PDT)
In-Reply-To: <CANeU7Q=vDAuBwWqy0=rbvkpgmzysCw=pfSEcwzyRRSZj3QrJbA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Tue, Sep 30, 2014 at 11:26 AM, Christopher Li <sparse@chrisli.org> wrote:
> I am thinking some thing in the test-suite like:
>
> set_deps sparsec sparse-llvm
> set_deps sparsei sparse-llvm
>
> ...
> get_deps `basename cmd`
> dep_cmd=$last_result

Actually, I try that, it is a little bit too complicated.

Your first approach is fine.

I end up using your V1 patch, with a small change to do exact match rather than
a wild cast. The wild cast has danger that match a sub word of the command.
e.g. if you try to disable command "sp", it will disable "sparse" as well.

Chris

diff --git a/validation/test-suite b/validation/test-suite
index 1c94aa8..784ff6b 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -111,13 +111,13 @@ do_test()
        fi

        # check for disabled commands
+       set -- $cmd
+       base_cmd=`basename $1`
        for i in $disabled_cmds; do
-               case "$cmd" in
-               *$i*)
+               if [ "$i" == "$base_cmd" ] ; then
                        disabled_tests=`expr $disabled_tests + 1`
                        return 3
-                       ;;
-               esac
+               fi
        done

        echo "     TEST    $test_name ($file)"
