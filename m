From: rubisher <rubisher@scarlet.be>
Subject: Re: cgcc and REAL_CC help
Date: Mon, 21 Dec 2009 16:42:01 +0000
Message-ID: <4B2FA559.4040102@scarlet.be>
References: <4B29F6C2.7040800@scarlet.be>	 <36ca99e90912170142p26b9b0aal1a08509d65c53047@mail.gmail.com>	 <4B2BB887.6060508@scarlet.be> <70318cbf0912201445m37b31c71r6209a26b40892461@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from hel.is.scarlet.be ([193.74.71.26]:39396 "EHLO hel.is.scarlet.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074AbZLUQmI (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 21 Dec 2009 11:42:08 -0500
In-Reply-To: <70318cbf0912201445m37b31c71r6209a26b40892461@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Li <christ.li@gmail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, linux-sparse@vger.kernel.org

Hello Chris,

Chris Li wrote:
> On Fri, Dec 18, 2009 at 9:14 AM, rubisher <rubisher@scarlet.be> wrote:
>> That said, my next issue is that "-E" which is disable by cgcc:
>> [snip]
>>    # If someone adds "-E", don't pre-process twice.
>>    $do_compile = 0 if $_ eq '-E';
>> [snip]
>>
>> If ever some of you knows why, I would be interested in?
> 
> My guess is that, both gcc and sparse pre-process print to stdout.
> So allow them both pre-process will mess up the result.
> 
That was also my guess but when I comment out this line and run the same script one time with 'REAL_CC=gcc-4.4 cgcc' and the
second time with 'gcc-4.4' the results are the same, thought?

> The current cgcc chose to let sparse do the pre-process and don't
> run the real cc. You can make the gcc does the real pro-process and
> sparse just check though.
> 
Yes I think that I would have to do more effort to sparse this code.

Tx,
	J.

> Chris
> 


