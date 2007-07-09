From: "Damien Lespiau" <damien.lespiau@gmail.com>
Subject: Re: [PATCH 6/6] Add a simple test script, embed expected results into test files
Date: Mon, 9 Jul 2007 23:27:53 +0200
Message-ID: <cbf3148c0707091427x18e246cdy6cedb12fe284bab9@mail.gmail.com>
References: <20070628053954.30704.66440.stgit@dv.roinet.com>
	 <20070628054019.30704.64375.stgit@dv.roinet.com>
	 <46836129.7050407@freedesktop.org>
	 <cbf3148c0706281159x7b252776nd08fd9bd9e36b92@mail.gmail.com>
	 <1183066733.2621.127.camel@josh-work.beaverton.ibm.com>
	 <cbf3148c0706281713l793c944fp372a2f91f6f9b18c@mail.gmail.com>
	 <1183076949.2621.196.camel@josh-work.beaverton.ibm.com>
	 <cbf3148c0707012159l65432435we10fd9370c282dc4@mail.gmail.com>
	 <46915C9E.503@freedesktop.org> <46919A4C.3090602@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.181]:9062 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423AbXGIV1z (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Jul 2007 17:27:55 -0400
Received: by ik-out-1112.google.com with SMTP id b32so665654ika
        for <linux-sparse@vger.kernel.org>; Mon, 09 Jul 2007 14:27:53 -0700 (PDT)
In-Reply-To: <46919A4C.3090602@freedesktop.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

(I removed Pavel from the cc: list as he probably does not want to read such
mails)

> Actually, this led me to a more important issue: I don't think the test suite
> output can mix stdout and stderr safely, because the order may differ if both
> have data.  Look at preprocessor18.c for an example.  I think the test suite
> needs to have a block for check-stdout-{start,end} and a block for
> check-stderr-{start,end}.

Absolutely !

 ../sparse -E preprocessor/preprocessor18.c 1> foo 2>&1 && cat foo
and
../sparse -E preprocessor/preprocessor18.c

are not giving the same result and I had the same conclusion as yours
before going to bed. I was actually thinking about splitting the output
between stderr and stdout too. I added 1: or 2: at the beginning of
output lines but I think I like check-(stdout|stderr)-(start,end) better.

However I bumped into another issue:
$ hexdump -C bar
00000000  0a 0a 78 78 78 0a 0a 0a                       |..xxx...|
$ foo=`cat bar`
$ echo "$foo" | hexdump -C
00000000  0a 0a 78 78 78 0a                                |..xxx.|

it eats the last new lines but one and not the first '\n's !
I still have to sort this out...

-- 
Damien
