From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/4] cgcc: avoid passing a sparse-only option to cc
Date: Sat, 25 Oct 2014 12:14:14 +0800
Message-ID: <CANeU7Qn-4gaom-LTRvdzKMKZ0hqtiJKSPPXM5q7a-r2v06Y+xA@mail.gmail.com>
References: <54398BA5.6050005@ramsay1.demon.co.uk>
	<CANeU7QnOJTKK___Vb3VpN=_x62wVpS=A57UkTQrSz0-GYBF5rQ@mail.gmail.com>
	<543EAFFA.6070503@ramsay1.demon.co.uk>
	<CANeU7Q=ruQhu19sY=mDyiBmyDCGRR+xmRE7SzN9BcGLRZWX8Bw@mail.gmail.com>
	<5443C8F8.2000003@ramsay1.demon.co.uk>
	<CANeU7Qk_H8fV_soAbtGjHXwKBw3BWJgABhNM+KFLmM-rVY4N8w@mail.gmail.com>
	<54484DEC.2010902@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:43209 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbaJYTzv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 25 Oct 2014 15:55:51 -0400
Received: by mail-qc0-f175.google.com with SMTP id b13so2357530qcw.20
        for <linux-sparse@vger.kernel.org>; Sat, 25 Oct 2014 12:55:50 -0700 (PDT)
In-Reply-To: <54484DEC.2010902@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Thomas Graf <tgraf@suug.ch>

On Thu, Oct 23, 2014 at 8:38 AM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
>
> Without putting too much thought into it, such a beast would probably
> look something like this:
>
>     #include <stddef.h>
>     #include <unistd.h>
>     #include <errno.h>
>
>     ssize_t xwrite(int fd, const void *buf, size_t len)
>     {
>         const char *p = buf;
>         ssize_t count = 0;
>
>         while (len > 0) {
>                 ssize_t nw = write(fd, p, len);
>                 if (nw < 0) {
>                         if (errno == EAGAIN || errno == EINTR)
>                                 continue; /* recoverable error */
>                         return -1;
>                 }
>                 len -= nw;
>                 p += nw;
>                 count += nw;
>         }
>         return count;
>     }
>
> Actually, I would need to think about what to do if write() returns
> zero. Such a return is not an error, it simply didn't write anything.
> Are we guaranteed that some progress will eventually be made, or
> should there be another check for non-progress in the loop. dunno. :(

The while loop need to have some ending conditions otherwise
it can result in no progress make on a loop. e.g. calling on a non
blocking file descriptor and the write will block.

I think for the compile-i386.c. It is fine just die on short write.
It is just an example program.


> Hmm, I don't understand this. _In general_, you don't know how many
> bytes you are going to write before you call printf() and you don't
> explicitly request any amount. Assuming no errors, which are indicated
> with a negative return value, printf() returns the number of bytes
> actually 'written'. The standard I/O routines, including all the internal
> buffering, are much easier to use than the raw system calls (you don't
> have to cater for short writes etc., like the code above, because the
> standard library takes care of all of that for you).

My feed back is base on the reason of the change. If your intend is
to get rid of the warning of not checking the error condition. Then the
right thing to do is to just check and handle it. Die on error is also one
kind of handle. Might be a bit harsh, but fine for the example program.
In this respect, printf is not better.

I am actually not sure how printf take care care of the short write.
"printf" is very complex. I image if there is real error on the file system
level. e.g. disk full. "printf" will have to return shorter than you expected.
So printf will not get rid of the short write completely.

>
> My preference for the first patch (replacing calls to write with printf),
> has little to do with this issue. I simply see no advantage in mixing
> calls to the standard I/O library with write() system calls. (The call
> to fflush(stdout) on line 889 has nothing to do with paranoia; it has to
> do with correctness and is very much needed!)

Then your intend is different than what I previously understand.
If you call that change to unify the writing style of printf vs write.
Converting write to use printf is acceptable. BTW, if there is no formatting
string, why not use some thing like "puts()" instead?

However, using printf without checking is not a right fix for the
reason to address error condition not check. It still have unchecked
error conditions.

> Using printf() is more portable than write(). The emit_insn_atom() could
> be greatly simplified by calling printf() directly rather than using
> a sprintf/write combo. (not implemented in my patch). I would be very
> surprised if using write() was any more efficient than printf(). I find

Actually write is more efficient than printf. "write" is just a wrapper to
the system call "write". "printf" is another strong. It is very complex.
But that is not relevant here.

I vote for left the patch as it is.

Thanks

Chris
