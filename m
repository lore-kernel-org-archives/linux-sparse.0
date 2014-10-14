From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] compile-i386.c: don't ignore return value of write(2)
Date: Tue, 14 Oct 2014 11:13:47 +0100
Message-ID: <543CF75B.1020507@ramsay1.demon.co.uk>
References: <543C5A43.9@ramsay1.demon.co.uk> <20141014031428.GA1009@thin>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:46603 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752778AbaJNKNw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 14 Oct 2014 06:13:52 -0400
In-Reply-To: <20141014031428.GA1009@thin>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On 14/10/14 04:14, Josh Triplett wrote:
> On Tue, Oct 14, 2014 at 12:03:31AM +0100, Ramsay Jones wrote:
>>
>> Some versions of gcc (e.g. v4.8.2) complain about ignoring the return
>> value of a call to the write(2) system call, since the system header
>> files have marked its declaration with the warn_unused_result attribute.
>>
>> In order to suppress the compiler warning, check the return value from
>> 'write' and, if it indicates an error (a negative return value), exit
>> the process using 'die' to display an error message. Replace a second
>> call to 'write', which does not provoke a compiler warning, with similar
>> code for consistency.
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> 
> That isn't the only way write() can fail; it can also do a partial
> write, in which case you need to loop and write the rest.  You might
> consider adding an xwrite() function which includes that logic.

I did consider doing exactly that, but I wanted a _minimal_ fix for a
program that is basically unmaintained. However, if Chris would like
such a patch, I will happily provide one! ;-)

> (Alternatively, you could use standard C IO, which doesn't have that
> problem.)

See the very first version of this patch. :-D (I still slightly prefer
the first patch, very closely followed by the second version; this is
the third attempt).

ATB,
Ramsay Jones



