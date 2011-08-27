From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: Reduce 'test-suite' run output
Date: Fri, 26 Aug 2011 19:11:04 -0700
Message-ID: <CANeU7Q=xTrKKCkuB4_RcA7L=99=psZAWQiawqSLMMyOUK6E-jQ@mail.gmail.com>
References: <1314366621-29361-1-git-send-email-penberg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:36375 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab1H0CLG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 26 Aug 2011 22:11:06 -0400
Received: by qyk38 with SMTP id 38so779844qyk.19
        for <linux-sparse@vger.kernel.org>; Fri, 26 Aug 2011 19:11:05 -0700 (PDT)
In-Reply-To: <1314366621-29361-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Aug 26, 2011 at 6:50 AM, Pekka Enberg <penberg@kernel.org> wrot=
e:
> There's more than 100 tests in the validation test suite. That makes =
it
> cumbersome to notice test breakage in because the results don't fit o=
n single
> page.

Looks good in a terminal. But if the output is piped to a file, it will=
 be hard
to read that file. We shouldn't do it for a non-terminal output.


> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo ""

Why not just "echo" instead. Without any argument, echo will just outpu=
t "\n".

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
