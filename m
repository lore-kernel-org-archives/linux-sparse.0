From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/4] cgcc: avoid passing a sparse-only option to cc
Date: Sat, 25 Oct 2014 13:32:01 +0100
Message-ID: <544B9841.6010009@ramsay1.demon.co.uk>
References: <54398BA5.6050005@ramsay1.demon.co.uk>	<CANeU7QnOJTKK___Vb3VpN=_x62wVpS=A57UkTQrSz0-GYBF5rQ@mail.gmail.com>	<543EAFFA.6070503@ramsay1.demon.co.uk>	<CANeU7Q=ruQhu19sY=mDyiBmyDCGRR+xmRE7SzN9BcGLRZWX8Bw@mail.gmail.com>	<5443C8F8.2000003@ramsay1.demon.co.uk>	<CANeU7Qk_H8fV_soAbtGjHXwKBw3BWJgABhNM+KFLmM-rVY4N8w@mail.gmail.com>	<54484DEC.2010902@ramsay1.demon.co.uk> <CANeU7Qn-4gaom-LTRvdzKMKZ0hqtiJKSPPXM5q7a-r2v06Y+xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:36650 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751885AbaJYUst (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 25 Oct 2014 16:48:49 -0400
In-Reply-To: <CANeU7Qn-4gaom-LTRvdzKMKZ0hqtiJKSPPXM5q7a-r2v06Y+xA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Thomas Graf <tgraf@suug.ch>

On 25/10/14 05:14, Christopher Li wrote:
> On Thu, Oct 23, 2014 at 8:38 AM, Ramsay Jones
> <ramsay@ramsay1.demon.co.uk> wrote:
>>
>> Without putting too much thought into it, such a beast would probably
>> look something like this:
>>
>>     #include <stddef.h>
>>     #include <unistd.h>
>>     #include <errno.h>
>>
>>     ssize_t xwrite(int fd, const void *buf, size_t len)
>>     {
>>         const char *p = buf;
>>         ssize_t count = 0;
>>
>>         while (len > 0) {
>>                 ssize_t nw = write(fd, p, len);
>>                 if (nw < 0) {
>>                         if (errno == EAGAIN || errno == EINTR)
>>                                 continue; /* recoverable error */
>>                         return -1;
>>                 }
>>                 len -= nw;
>>                 p += nw;
>>                 count += nw;
>>         }
>>         return count;
>>     }
>>
>> Actually, I would need to think about what to do if write() returns
>> zero. Such a return is not an error, it simply didn't write anything.
>> Are we guaranteed that some progress will eventually be made, or
>> should there be another check for non-progress in the loop. dunno. :(
> 
> The while loop need to have some ending conditions otherwise
> it can result in no progress make on a loop. e.g. calling on a non
> blocking file descriptor and the write will block.

Yeah, I just typed that directly into my mail client and the first version
had an 'if (nw == 0) return -1;' in the loop. However, I couldn't justify
doing that, because it is not an error. I briefly thought about adding a
'non-progress' count to use to exit, but at this point I felt I would have
to go away and start reading ... so I just punted. It was only a quick
'something like this ...' anyway! ;-)

> I think for the compile-i386.c. It is fine just die on short write.
> It is just an example program.

Again, I'm happy to go with this too!

>> Hmm, I don't understand this. _In general_, you don't know how many
>> bytes you are going to write before you call printf() and you don't
>> explicitly request any amount. Assuming no errors, which are indicated
>> with a negative return value, printf() returns the number of bytes
>> actually 'written'. The standard I/O routines, including all the internal
>> buffering, are much easier to use than the raw system calls (you don't
>> have to cater for short writes etc., like the code above, because the
>> standard library takes care of all of that for you).
> 
> My feed back is base on the reason of the change. If your intend is
> to get rid of the warning of not checking the error condition. Then the
> right thing to do is to just check and handle it. Die on error is also one
> kind of handle. Might be a bit harsh, but fine for the example program.
> In this respect, printf is not better.

OK, point taken.

[snip]

> I vote for left the patch as it is.

Me too.

Thanks!

ATB,
Ramsay Jones



