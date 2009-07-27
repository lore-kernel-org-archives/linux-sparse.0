From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] test-suite: integrate unhandled proprocessor tests
Date: Mon, 27 Jul 2009 14:04:00 -0700
Message-ID: <70318cbf0907271404i34dac921ge2b3f4d4dcc7c596@mail.gmail.com>
References: <20090727181048.18280.38099.stgit@f10box.hanneseder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:53920 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754557AbZG0VKc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 27 Jul 2009 17:10:32 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1804390qwh.37
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jul 2009 14:10:32 -0700 (PDT)
In-Reply-To: <20090727181048.18280.38099.stgit@f10box.hanneseder.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Hannes Eder <hannes@hanneseder.net>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

On Mon, Jul 27, 2009 at 11:13 AM, Hannes Eder<hannes@hanneseder.net> wr=
ote:
> Instrument validate/preprocessor/preproprocessor*.c to be integrated
> into the test-suite where missing and add an additional test case.

Thanks, applied.

> Ok there is a difference in the number of empty lines, who cares, but
> spares outputs a "," and cpp does not.
>
> Could somebody with more insight comment on this? =A0Al? :)
>
> Meanwhile I marked this test as "check-known-to-fail".

Currently sparse did not handle ##__VA_ARGS__ the same ways
as gcc. Take a look at parse_expansion(). It marks TOKEN_GNU_KLUDGE
only if it saw "," right before "##__VA_ARGS__".  So ",##x##__VA_ARGS__=
"
will not get generate TOKEN_GNU_KLUDE.

The fix is that ##__VA_ARGS__ should kick in *after* the argument
list has been expanded. It literally delete the previous "," if __VA_AR=
GS__ is
empty.

Am I missing any thing, AI?

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
