From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/3] testsuite: add tag to ignore the output/error
Date: Fri, 18 Nov 2016 01:15:00 +0800
Message-ID: <CANeU7QkhkigFzzvq5tNxyxNKnKfvgoKDx4010VOmQiKtHQRYbw@mail.gmail.com>
References: <20161110144520.24965-1-luc.vanoostenryck@gmail.com> <20161110144520.24965-2-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:35442 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933059AbcKQRPB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 12:15:01 -0500
Received: by mail-it0-f67.google.com with SMTP id b123so16556677itb.2
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 09:15:01 -0800 (PST)
In-Reply-To: <20161110144520.24965-2-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Applied.

Chris

On Thu, Nov 10, 2016 at 10:45 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Currently the test suite always check the exit value and the output
> of the command used for the test. This is fine and allow use to catch
> the most common situations:
> - failure or crash (via the exit value)
> - (un)expected output (like when testing the result of the preprocessor)
> - (un)expected errors & warnings (like when testing sparse's warnings)
>
> But sometimes, we're not interested in the output or the output (as is)
> is simply not meaningful for the test or can't be compared textually
> to some reference.
>
> This patch add two new tags (check-output-ignore & check-error-ignore),
> telling to test suite to ignore the content of stdout or stderr when
> testing this file.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  Documentation/test-suite | 6 ++++++
>  validation/test-suite    | 2 ++
>  2 files changed, 8 insertions(+)
>
> diff --git a/Documentation/test-suite b/Documentation/test-suite
> index 6c4f24f6..6936feeb 100644
> --- a/Documentation/test-suite
> +++ b/Documentation/test-suite
> @@ -29,6 +29,12 @@ check-output-start / check-output-end (optional)
>         The expected output (stdout and stderr) of check-command lies between
>         those two tags. It defaults to no output.
>
> +check-output-ignore / check-error-ignore (optional)
> +       Don't check the expected output (stdout or stderr) of check-command
> +       (usefull when this output is not comparable or if you're only interested
> +       in the exit value).
> +       By default this check is done.
> +
>  check-known-to-fail (optional)
>         Mark the test as being known to fail.
>
> diff --git a/validation/test-suite b/validation/test-suite
> index df5a7c60..0d874e07 100755
> --- a/validation/test-suite
> +++ b/validation/test-suite
> @@ -146,6 +146,8 @@ do_test()
>         actual_exit_value=$?
>
>         for stream in output error; do
> +               grep -s -q "check-$stream-ignore" $file && continue
> +
>                 diff -u "$file".$stream.expected "$file".$stream.got > "$file".$stream.diff
>                 if [ "$?" -ne "0" ]; then
>                         error "actual $stream text does not match expected $stream text."
> --
> 2.10.1
>
