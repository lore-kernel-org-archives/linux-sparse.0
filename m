From: "Balbir Singh" <bsingharora@gmail.com>
Subject: Re: sparse (cgcc) vs lintool
Date: Fri, 6 Jun 2008 18:17:16 +0530
Message-ID: <661de9470806060547j720f063fn7c1e4c88b3089738@mail.gmail.com>
References: <20080606123434.GA23323@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:18497 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269AbYFFMrX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Jun 2008 08:47:23 -0400
Received: by py-out-1112.google.com with SMTP id p76so758424pyb.10
        for <linux-sparse@vger.kernel.org>; Fri, 06 Jun 2008 05:47:22 -0700 (PDT)
In-Reply-To: <20080606123434.GA23323@lst.de>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-sparse@vger.kernel.org

On Fri, Jun 6, 2008 at 6:04 PM, Christoph Hellwig <hch@lst.de> wrote:
> When trying to compile xfsprogs (from oss.sgi.com/projects/xfs)
>
> hch@bigmac:~/work/xfs-cmds/xfsprogs$ CC=~/bin/cgcc ./configure
> hch@bigmac:~/work/xfs-cmds/xfsprogs$ make
>
> I get this error:
>
> === libxfs ===
> /usr/bin/libtool --mode=compile /home/hch/bin/cgcc -I. -g -O2 -DNDEBUG
> -DVERSION=\"2.9.8\" -DLOCALEDIR=\"/usr/local/share/locale\"
> -DPACKAGE=\"xfsprogs\" -I../include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
> -funsigned-char -fno-strict-aliasing -Wall   -c bit.c
> libtool: compile: unable to infer tagged configuration
> libtool: compile: specify a tag with `--tag'
> make[1]: *** [bit.lo] Error 1
> make: *** [default] Error 2
>
> Any idea what's up with sparse and libtool?

Looking at the FAQ from

http://www.astro.gla.ac.uk/~norman/star/ssn78/ssn78.htx/N-a5b1.html

I've just been told that libtool is ``unable to infer tagged
configuration''. What on earth is that supposed to mean?
    I'm not sure what this is supposed to mean exactly, but what it
seems to mean in practice is that libtool has become terribly confused
about your compiler. Very probably, you forced ./configure to use a
particular compiler by specifying one of the F77, FC or CC environment
variables at configure time. You may have forgotten that you have that
variable set.

    Alternatively, you may be unaware that that variable is set: a
known manifestation of this problem is that the IRAF startup script
sets F77 to be an IRAF-specific script, which works OK from the
command-line (given that you want to use IRAF), but which leaves
libtool in a confused heap.

    This problem has also been spotted in the form libtool: compile:
specify a tag with `--tag', with apparently the same cause.

    See Section 2.1.5 for more discussion of these variables.


Did gcc or any other development tools package change on your system?

Balbir
