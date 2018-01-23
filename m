From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] test-suite: handle format with filename.c not existing
Date: Tue, 23 Jan 2018 03:22:33 -0800
Message-ID: <CANeU7QkL3UrbsHRVhwXcAas7cBOTVyzHsGzZSKr0zAiEBFAWpg@mail.gmail.com>
References: <5d19aa93-b421-eb1f-3a4c-92fc9476747a@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:39004 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeAWLWf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 23 Jan 2018 06:22:35 -0500
Received: by mail-qt0-f169.google.com with SMTP id f4so287126qtj.6
        for <linux-sparse@vger.kernel.org>; Tue, 23 Jan 2018 03:22:34 -0800 (PST)
In-Reply-To: <5d19aa93-b421-eb1f-3a4c-92fc9476747a@infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Jan 22, 2018 at 11:05 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> In error(), quiet is undefined when the command:
>   $ ./test-suite format filename1.c foobar1
>
> is used and filename1.c does not exist. This causes a shell script error:
>   ./test-suite: line 147: [: : integer expression expected
>
> because $quiet is undefined in
>   [ "$quiet" -ne 1 ] && echo "error: $1"
> so the error message is lost.
>
> Just initialize quiet before any command line parsing.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  validation/test-suite |    2 ++
>  1 file changed, 2 insertions(+)
>
> --- sprs.orig/validation/test-suite
> +++ sprs.next/validation/test-suite
> @@ -368,6 +368,8 @@ arg_file()
>         return 0
>  }
>
> +quiet=0
> +

Good catch. I think this fix is not ideal.
There is another quite=0 inside "do_test()".
<quote>
quiet=0
[ $must_fail -eq 1 ] && [ $V -eq 0 ] && quiet=1
</quote>

The "quite=0" only cover the case inside "do_test()".
Even with this patch,  If  the "quite" is used outside of
"do_test()", The "quite" variable is not set properly according to "V".

I would suggest move the above two quote line out side
of "do_test()", right after the default value of "V", in the
beginning of the file:

<quote>
# defaults to not verbose
[ -z "$V" ] && V=0
</quote>

Chris
