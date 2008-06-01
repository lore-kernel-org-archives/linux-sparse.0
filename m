From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: Re: Undetected error cases
Date: Sun, 1 Jun 2008 21:46:28 +0200
Message-ID: <19f34abd0806011246nd615793o7e09ceae8dee73e6@mail.gmail.com>
References: <19f34abd0806011142x7e56fd8gf51358bf606ede91@mail.gmail.com>
	 <1212346705.2727.6.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:10302 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbYFATq2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Jun 2008 15:46:28 -0400
Received: by rv-out-0506.google.com with SMTP id l9so710623rvb.1
        for <linux-sparse@vger.kernel.org>; Sun, 01 Jun 2008 12:46:28 -0700 (PDT)
In-Reply-To: <1212346705.2727.6.camel@dv>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

On Sun, Jun 1, 2008 at 8:58 PM, Pavel Roskin <proski@gnu.org> wrote:
> On Sun, 2008-06-01 at 20:42 +0200, Vegard Nossum wrote:
>
>> None of these produce errors or even warnings when they are run
>> through sparse. I probably won't get around to fixing these myself
>> since I'm not that familiar with sparse internals. This is just a
>> heads up :-)
>
> Still, you may be able to create test cases for the testsuite.

Ah, that's be true. I have now submitted the .c files that should
produce the errors/warnings, but I can't seem to find an actual
testsuite in which to hook them. The existing test-* files seem to
test the API, not the files to be parsed.

Vegard

-- 
"The animistic metaphor of the bug that maliciously sneaked in while
the programmer was not looking is intellectually dishonest as it
disguises that the error is the programmer's own creation."
	-- E. W. Dijkstra, EWD1036
