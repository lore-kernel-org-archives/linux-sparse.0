From: "Anderson Lizardo" <anderson.lizardo@gmail.com>
Subject: Re: [PATCH 6/6] Add a simple test script, embed expected results into test files
Date: Tue, 10 Jul 2007 20:48:12 -0400
Message-ID: <5b5833aa0707101748x2a8cbc10ocaf44e92d19802fc@mail.gmail.com>
References: <20070628053954.30704.66440.stgit@dv.roinet.com>
	 <46836129.7050407@freedesktop.org>
	 <cbf3148c0706281159x7b252776nd08fd9bd9e36b92@mail.gmail.com>
	 <1183066733.2621.127.camel@josh-work.beaverton.ibm.com>
	 <cbf3148c0706281713l793c944fp372a2f91f6f9b18c@mail.gmail.com>
	 <1183076949.2621.196.camel@josh-work.beaverton.ibm.com>
	 <cbf3148c0707012159l65432435we10fd9370c282dc4@mail.gmail.com>
	 <46915C9E.503@freedesktop.org> <46919A4C.3090602@freedesktop.org>
	 <cbf3148c0707091427x18e246cdy6cedb12fe284bab9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:24599 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbXGKAsN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 10 Jul 2007 20:48:13 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2097407wah
        for <linux-sparse@vger.kernel.org>; Tue, 10 Jul 2007 17:48:12 -0700 (PDT)
In-Reply-To: <cbf3148c0707091427x18e246cdy6cedb12fe284bab9@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Damien Lespiau <damien.lespiau@gmail.com>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org

On 7/9/07, Damien Lespiau <damien.lespiau@gmail.com> wrote:
> However I bumped into another issue:
> $ hexdump -C bar
> 00000000  0a 0a 78 78 78 0a 0a 0a                       |..xxx...|
> $ foo=`cat bar`
> $ echo "$foo" | hexdump -C
> 00000000  0a 0a 78 78 78 0a                                |..xxx.|
>
> it eats the last new lines but one and not the first '\n's !
> I still have to sort this out...

Actually, it eats both newlines... The trailing newline that still
appears is from "echo" command, which appends a newline by default.
Try:

echo -n "$foo" | hexdump -C

instead. Anyway, this is from "man bash":

"Command Substitution
[...]
Bash performs the expansion by executing command and replacing the
command substitution with the standard output of the command, with any
trailing newlines  deleted. Embedded newlines are not deleted, but
they may be removed during word splitting."

So I suppose this is an expected behaviour.

Regards,
-- 
Anderson Lizardo
