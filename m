From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] sparse: Reduce 'test-suite' run output
Date: Tue, 30 Aug 2011 17:42:28 -0700
Message-ID: <CANeU7QmpvS_qVWifU32EjCb+oFM7gc7WJ3qW5ERiQxvL9mmfTQ@mail.gmail.com>
References: <1314732256-6113-1-git-send-email-penberg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59685 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202Ab1HaAm3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 30 Aug 2011 20:42:29 -0400
Received: by wyg24 with SMTP id 24so127470wyg.19
        for <linux-sparse@vger.kernel.org>; Tue, 30 Aug 2011 17:42:28 -0700 (PDT)
In-Reply-To: <1314732256-6113-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Ben Pfaff <blp@cs.stanford.edu>, =?ISO-8859-1?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, Aug 30, 2011 at 12:24 PM, Pekka Enberg <penberg@kernel.org> wro=
te:
> -
> - =A0 =A0 =A0 echo " =A0 =A0 TEST =A0 =A0$test_name ($file)"
> + =A0 =A0 =A0 if test -t 1; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf "\r =A0 =A0 TEST =A0 =A0%-80s" "=
$file ($test_name)"
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo " =A0 =A0 TEST =A0 =A0$test_name (=
$file)"
> + =A0 =A0 =A0 fi

Can you test the terminal once and save the result to a local variable?
There is no need to run the test over and over again for every line of =
output.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if [ "$?" -ne "0" ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo ""

Please just echo. Empty argument is not necessary.
Also, shouldn't this wrap by "if terminial" test as well?
You are adding new lines for non terminal case.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error "actual $stream =
text does not match expected $stream text."
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =A0"see $file.$s=
tream.* for further investigation."
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cat "$file".$stream.di=
ff
> @@ -163,6 +167,7 @@ do_test_suite()
>
> =A0 =A0 =A0 =A0# prints some numbers
> =A0 =A0 =A0 =A0tests_nr=3D`expr $ok_tests + $ko_tests`
> + =A0 =A0 =A0 echo ""

Same here.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
