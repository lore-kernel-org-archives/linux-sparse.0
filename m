From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/4] cgcc: avoid passing a sparse-only option to cc
Date: Thu, 23 Oct 2014 01:38:04 +0100
Message-ID: <54484DEC.2010902@ramsay1.demon.co.uk>
References: <54398BA5.6050005@ramsay1.demon.co.uk>	<CANeU7QnOJTKK___Vb3VpN=_x62wVpS=A57UkTQrSz0-GYBF5rQ@mail.gmail.com>	<543EAFFA.6070503@ramsay1.demon.co.uk>	<CANeU7Q=ruQhu19sY=mDyiBmyDCGRR+xmRE7SzN9BcGLRZWX8Bw@mail.gmail.com>	<5443C8F8.2000003@ramsay1.demon.co.uk> <CANeU7Qk_H8fV_soAbtGjHXwKBw3BWJgABhNM+KFLmM-rVY4N8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:41360 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932623AbaJWAiP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Oct 2014 20:38:15 -0400
In-Reply-To: <CANeU7Qk_H8fV_soAbtGjHXwKBw3BWJgABhNM+KFLmM-rVY4N8w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Thomas Graf <tgraf@suug.ch>

On 22/10/14 01:23, Christopher Li wrote:
> On Sun, Oct 19, 2014 at 10:21 PM, Ramsay Jones
> <ramsay@ramsay1.demon.co.uk> wrote:
>> Sorry for the late reply, it's been a busy few days. ;-)
>>
>> On 16/10/14 02:45, Christopher Li wrote:
>>> Hi,
>>>
>>> I create a branch in the chrisl repo call "review-ramsay" for your new
>>> follow up patches.
>>> I plan to do incremental fix up if any on that branch. Then when we
>>> both happy about it,
>>> I will do rebase and smash the commit before push to master branch.
>>
>> Yes, I noticed the new branch - thanks!
>>
>> Did you have any thoughts regarding Josh Triplett's comments on the
>> "compile-i386.c: don't ignore return value of write(2)" patch?
> 
> I am fine with either way. The current fix is fine.

I'm fine with this too. ;-)

>                                                     If you are up for
> a new xwrite function, that is of course fine as well.

Without putting too much thought into it, such a beast would probably
look something like this:

    #include <stddef.h>
    #include <unistd.h>
    #include <errno.h>
    
    ssize_t xwrite(int fd, const void *buf, size_t len)
    {
    	const char *p = buf;
    	ssize_t count = 0;
    
    	while (len > 0) {
    		ssize_t nw = write(fd, p, len);
    		if (nw < 0) {
    			if (errno == EAGAIN || errno == EINTR)
    				continue; /* recoverable error */
    			return -1;
    		}
    		len -= nw;
    		p += nw;
    		count += nw;
    	}
    	return count;
    }
    
Actually, I would need to think about what to do if write() returns
zero. Such a return is not an error, it simply didn't write anything.
Are we guaranteed that some progress will eventually be made, or
should there be another check for non-progress in the loop. dunno. :(

>                                                         Using printf()
> is not much an improvement because printf() can still return
> bytes less than the amount you requested.

Hmm, I don't understand this. _In general_, you don't know how many
bytes you are going to write before you call printf() and you don't
explicitly request any amount. Assuming no errors, which are indicated
with a negative return value, printf() returns the number of bytes
actually 'written'. The standard I/O routines, including all the internal
buffering, are much easier to use than the raw system calls (you don't
have to cater for short writes etc., like the code above, because the
standard library takes care of all of that for you).

My preference for the first patch (replacing calls to write with printf),
has little to do with this issue. I simply see no advantage in mixing
calls to the standard I/O library with write() system calls. (The call
to fflush(stdout) on line 889 has nothing to do with paranoia; it has to
do with correctness and is very much needed!)

Using printf() is more portable than write(). The emit_insn_atom() could
be greatly simplified by calling printf() directly rather than using
a sprintf/write combo. (not implemented in my patch). I would be very
surprised if using write() was any more efficient than printf(). I find
the code easier to comprehend without mixing I/O styles. So, once again,
what advantage does write() bestow?

Having said that, although I think the latest patch is perfectly fine, if
you would like me to try expanding on the above xwrite() idea, just let me
know.

ATB,
Ramsay Jones


