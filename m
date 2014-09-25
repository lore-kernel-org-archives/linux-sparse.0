From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: Make -Werror turn warnigns into errors
Date: Thu, 25 Sep 2014 10:46:21 +0800
Message-ID: <CANeU7QnOZ8bef1L_rn50DOuercW3k9Ra4A4gJp6MiR6zx0YQ7Q@mail.gmail.com>
References: <ddf8540942f71841dd90c5218da944cebef4a514.1409770383.git.tgraf@suug.ch>
	<CANeU7QnRFxZ+OV5G2W3tC+tBnYNNcQsH_YEB=cyHmAfmfYc1PQ@mail.gmail.com>
	<20140924154207.GD4966@casper.infradead.org>
	<CANeU7QmMGAc9Y+VMhQbf9JyUBZAL5x=JGQKvMO=988S60wOwUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:46138 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbaIYCqW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Sep 2014 22:46:22 -0400
Received: by mail-wi0-f172.google.com with SMTP id em10so8036415wid.17
        for <linux-sparse@vger.kernel.org>; Wed, 24 Sep 2014 19:46:21 -0700 (PDT)
In-Reply-To: <CANeU7QmMGAc9Y+VMhQbf9JyUBZAL5x=JGQKvMO=988S60wOwUg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Graf <tgraf@suug.ch>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Sep 25, 2014 at 7:16 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Wed, Sep 24, 2014 at 11:42 PM, Thomas Graf <tgraf@suug.ch> wrote:
>>
>> The return value of thest will only be non zero if an actual error
>> has been detected. It will remain zero if only warnings have been
>> found. So we would need to parse the text between "check-exit-start"
>> and "check-error-end" for the string "error:" or something a like
>> that. I found that to be fragile and the explicit declaration of an
>> expected failure to be superior as it also verifies whether an
>> expected warning is properly treated as a warning or not.
>>
>
> It does not conflict with what I said. My point is setting the *default*
> value of the test case. You can still set the expected return value
> explicitly using ""check-exit-value". There is nothing imprecise about it.
>
> It is just need a regular expression. In python that will be:
> r"(?m)^\S+?:\d+:\d+: error:".
> The test case is written in Perl, it will need some conversion in regular
> expression pattern.

So the bash version will be look like this, I briefly test it
seems pass all test cases.

Any feed back?

Chris

diff --gidiff --git a/validation/test-suite b/validation/test-suite
index 3c011c6..f9cb6fe 100755
--- a/validation/test-suite
+++ b/validation/test-suite
diff --git a/validation/test-suite b/validation/test-suite
index 3c011c6..f9cb6fe 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -106,20 +106,26 @@ do_test()
        fi
        verbose "Using command       : $cmd"

+       # grab the expected output
+       sed -n '/check-output-start/,/check-output-end/p' $file \
+               | grep -v check-output > "$file".output.expected
+       sed -n '/check-error-start/,/check-error-end/p' $file \
+               | grep -v check-error > "$file".error.expected
+
        # grab the expected exit value
        get_value "check-exit-value" $file
        if [ "$?" -eq "0" ]; then
                expected_exit_value=`echo $last_result | tr -d ' '`
        else
-               expected_exit_value=0
+               grep -q -E "^[^:]+:[[:digit:]]+:[[:digit:]]+: error:"
"$file".error.expected
+               if  [ "$?" -eq "0" ]; then
+                       expected_exit_value=1
+               else
+                       expected_exit_value=0
+               fi
        fi
        verbose "Expecting exit value: $expected_exit_value"

-       # grab the expected output
-       sed -n '/check-output-start/,/check-output-end/p' $file \
-               | grep -v check-output > "$file".output.expected
-       sed -n '/check-error-start/,/check-error-end/p' $file \
