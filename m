From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 1/5] sparse: Show expected vs. actual output on test failure
Date: Fri, 26 Aug 2011 12:10:24 +0300
Message-ID: <4E576300.2070609@kernel.org>
References: <1314021451-24808-1-git-send-email-penberg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38888 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022Ab1HZJKa (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 26 Aug 2011 05:10:30 -0400
Received: by wyg24 with SMTP id 24so2284585wyg.19
        for <linux-sparse@vger.kernel.org>; Fri, 26 Aug 2011 02:10:29 -0700 (PDT)
In-Reply-To: <1314021451-24808-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>

On 8/22/11 4:57 PM, Pekka Enberg wrote:
> This patch changes 'make check' output to show sparse output compared to
> expected results upon unexpected test failure. For example,
> static-forward-decl.c output would look like this if it would not be tagged as
> "known to fail":
>
>         TEST     static forward declaration (static-forward-decl.c)
>    error: actual error text does not match expected error text.
>    --- static-forward-decl.c.error.expected	2011-08-22 06:29:40.000000000 +0000
>    +++ static-forward-decl.c.error.got	2011-08-22 06:29:40.000000000 +0000
>    @@ -0,0 +1 @@
>    +static-forward-decl.c:3:5: warning: symbol 'f' was not declared. Should it be static?
>    error: see static-forward-decl.c.error.* for further investigation.
>    info: test 'static-forward-decl.c' is known to fail
>
> This makes it easier to detect and analyze test breakage.
>
> Cc: Christopher Li<sparse@chrisli.org>
> Cc: Linus Torvalds<torvalds@linux-foundation.org>
> Signed-off-by: Pekka Enberg<penberg@kernel.org>
> ---
>   validation/test-suite |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/validation/test-suite b/validation/test-suite
> index 42f7bd7..7549fd2 100755
> --- a/validation/test-suite
> +++ b/validation/test-suite
> @@ -146,6 +146,8 @@ do_test()
>   		if [ "$?" -eq "0" ]; then
>   			echo "info: test '$file' is known to fail"
>   			known_ko_tests=`expr $known_ko_tests + 1`
> +		else
> +			cat "$file".$stream.diff
>   		fi
>   		return 1
>   	else

Chris, the patch you committed is different from mine:

http://git.kernel.org/?p=devel/sparse/chrisl/sparse.git;a=commitdiff;h=a7a00d5108c36b8baaf54814aa1f42583dabc754

Your patch now makes the runner verbose for "known to fail" tests
which is definitely not something we should do. If someone tagged
the test as "known to fail", we should treat it just like we treat
passed test cases.

The whole point of my patch was to make "make check" pinpoint
*unexpected* breakage so that anyone who bothers to do "make check"
on their patches can never cause regressions.

                         Pekka
