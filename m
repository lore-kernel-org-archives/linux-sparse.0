From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH 0/10] Sparse linker
Date: Thu, 4 Sep 2008 14:24:57 -0700
Message-ID: <70318cbf0809041424n1a773e0t3a68414a44ce79f3@mail.gmail.com>
References: <1220478954-22678-1-git-send-email-alexey.zaytsev@gmail.com>
	 <70318cbf0809031816m69565c5aj9417d9a2e136770d@mail.gmail.com>
	 <f19298770809032103h5ea34122g44fda595d775cecf@mail.gmail.com>
	 <70318cbf0809040027i79476a4ds3d1086f5ca434d9d@mail.gmail.com>
	 <f19298770809040241h39703754i5bcac349e1d151c6@mail.gmail.com>
	 <70318cbf0809040335k5ea24032sffc11a8793b43b40@mail.gmail.com>
	 <f19298770809040629t1eb86f2co66a87e564bcd8684@mail.gmail.com>
	 <f19298770809040635s611ef3c3sa05111743ea60631@mail.gmail.com>
	 <70318cbf0809041204y75fa8f58vd6d1cfc7317b4fff@mail.gmail.com>
	 <f19298770809041321p53e81b93i6a6f62395b53af88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:8642 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039AbYIDVY7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 4 Sep 2008 17:24:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so541490fgg.17
        for <linux-sparse@vger.kernel.org>; Thu, 04 Sep 2008 14:24:58 -0700 (PDT)
In-Reply-To: <f19298770809041321p53e81b93i6a6f62395b53af88@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>, Codrin Alexandru Grajdeanu <grcodal@gmail.com>

On Thu, Sep 4, 2008 at 1:21 PM, Alexey Zaytsev <alexey.zaytsev@gmail.com> wrote:
> Mostly ack here, but I still think the C code has two advantages over
> binaries: It's easy to read, and it's an easy way to get the shared
> library filled with the data, see below.

It does not stop you to have some parsing tool to generate readable
format from the object dump. But using the C source as primary way to
dump object is letting the tail whack the dog. The on disk format should
be optimized towards easy for checker rather than human to read it.

> The huge disadvantage is the time and the memory it takes to compile
> the C code.

And the run time dependency of gcc.

> Here I have to disagree. Loading the data from an .so might actually the
> most evfficient method. See, the bulk of data of the .so is simply mmap'ed
> read-only, with only the GOT being read-write, and when mapping with
> RTLD_LAZY, the pointers are resolved only when you follow them, completely
> transparently to us. You don't need the fine-grained control, the OS just does
> the right thing for you. And if the checker needs to look at the bulk
> of the data,

Are you sure?

Quote the man page:
===================
RTLD_LAZY
    Perform lazy binding. Only resolve symbols as the code that
references them is executed. If the symbol is never referenced, then
it is never resolved. (Lazy binding is only performed for function
references; references to variables are always immediately bound when
the library is loaded.)
===================

Your symbol is store as DATA  nodes. Not functions. You never EXECUTE
your sparse object code. The RTLD_LAZY has ZERO effect on them. All the symbol
has to be immediately bounded. How can you tell which data pointer is lazy bound
given that all the data value is possible in the pointer?

> it cat dlopen with RTLD_NOW. When multiple different checkers are being run
> over the .so, the bulk of memory is shared between the processes, which I
> think matters a lot. The memory is cheap, but now the number of cores
> is growing.
> E.g. if you've got 4 cores and 4 gigs of RAM, it's only one gig per
> core, and wasting
> 300 megabytes per process just to load the data doasn't look like a good idea.

Even they are mmaped. Every symbol have to be touch up. So they need
to swap in and COW. The COW memory can't be shared between process
at all.  This is against the tradition of sparse being a small and neat tools.

I have to NACK this approach especially I know there is alternative better
way to do it. My laptop does not have 4 gigs of ram and it only have one core,
but I still want to run the checker as fast as possible on it.


> That should be completely possible with both approaches. I don't see any
> difference here.

I don't think so. See above comment about RTLD_LAZY.

>
> This way, you don't have the transparency. You either need to load all the
> data into memory, one structure after the other, and link them together,
> basically going the same stuff dlopen() does for you,  or you'll need to
> use special functions/macros to access the data from your checker.

Yes, it need one bit of information of this symbol has been resolve
or not.

That does not need to test inside the checker though.
The loader can make sure the symbol that the specific checker want
are all resolved before it hand it over to the checker. On the typical checking
path, there is only very small percent of the data checker care about.
Spending CPU and memory on those structure that the checker  don't
care is a big waste.

We don't really need to link them into one big piece of object as long as
we can efficiently look up which object contain the symbol I want.
I see linking into one big piece of object and have to load them together
as serious disadvantage.

After the checker is done with object, ideally the checker can release it.
I don't want the checker load every objects into memory before it
can work on it. This obviously does not scale.

> I'm looking into it now. Thank you for sharing.
>
> One crazy idea is... why can't we actually produce shared object binaries
> directly... Maybe it won't be all that hard to generate valid ELF...
> Just crazy probably.

I don't mind to use ELF format as long as it is simple and easy to
use. Keep in mind that the object file format used by sparse has
slightly different design goals. I did try ELF a little bit but I did not go
very far.

Chris
