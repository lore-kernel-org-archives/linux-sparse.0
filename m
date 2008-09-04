From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: [PATCH 0/10] Sparse linker
Date: Fri, 5 Sep 2008 00:21:10 +0400
Message-ID: <f19298770809041321p53e81b93i6a6f62395b53af88@mail.gmail.com>
References: <1220478954-22678-1-git-send-email-alexey.zaytsev@gmail.com>
	 <70318cbf0809031808u8610f3h4b3d53a7b76a7799@mail.gmail.com>
	 <70318cbf0809031816m69565c5aj9417d9a2e136770d@mail.gmail.com>
	 <f19298770809032103h5ea34122g44fda595d775cecf@mail.gmail.com>
	 <70318cbf0809040027i79476a4ds3d1086f5ca434d9d@mail.gmail.com>
	 <f19298770809040241h39703754i5bcac349e1d151c6@mail.gmail.com>
	 <70318cbf0809040335k5ea24032sffc11a8793b43b40@mail.gmail.com>
	 <f19298770809040629t1eb86f2co66a87e564bcd8684@mail.gmail.com>
	 <f19298770809040635s611ef3c3sa05111743ea60631@mail.gmail.com>
	 <70318cbf0809041204y75fa8f58vd6d1cfc7317b4fff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:14873 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbYIDUVL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 4 Sep 2008 16:21:11 -0400
Received: by wa-out-1112.google.com with SMTP id j37so66523waf.23
        for <linux-sparse@vger.kernel.org>; Thu, 04 Sep 2008 13:21:11 -0700 (PDT)
In-Reply-To: <70318cbf0809041204y75fa8f58vd6d1cfc7317b4fff@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>, Codrin Alexandru Grajdeanu <grcodal@gmail.com>

On Thu, Sep 4, 2008 at 11:04 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Thu, Sep 4, 2008 at 6:35 AM, Alexey Zaytsev <alexey.zaytsev@gmail.com> wrote:
>
>>> Ok, let me try to explain how the stuff works. Please note that in
>>
>> Ugh, my pretty code listings got corrupted by the bloody gmail.
>> Here is a better version: http://zaytsev.su/explanation.txt
>
> Thanks for your detail explain. It just confirm my reading of your
> code. I stand by my original feedback:
>
> - Using C source code as the output format is bad and unnecessary.
>  It depend on gcc to process the intermediate C source file.
>
Mostly ack here, but I still think the C code has two advantages over
binaries: It's easy to read, and it's an easy way to get the shared
library filled with the data, see below.

The huge disadvantage is the time and the memory it takes to compile
the C code.

> - Using dlopen to load the module does not have the fine grain control
>  of the which symbol need to resolve and which is doesn't. The linked
>  sparse object code for the whole linux kernel will be huge. Dynamic
>  loading of 300M bytes of .so file is not fun.

Here I have to disagree. Loading the data from an .so might actually the
most evfficient method. See, the bulk of data of the .so is simply mmap'ed
read-only, with only the GOT being read-write, and when mapping with
RTLD_LAZY, the pointers are resolved only when you follow them, completely
transparently to us. You don't need the fine-grained control, the OS just does
the right thing for you. And if the checker needs to look at the bulk
of the data,
it cat dlopen with RTLD_NOW. When multiple different checkers are being run
over the .so, the bulk of memory is shared between the processes, which I
think matters a lot. The memory is cheap, but now the number of cores
is growing.
E.g. if you've got 4 cores and 4 gigs of RAM, it's only one gig per
core, and wasting
300 megabytes per process just to load the data doasn't look like a good idea.

> - I can see you link all the define symbol together that way. In order to do
>  inter-function check effectively, we need the have the reverse mapping
>  as well. It need to perform task like this:
>  "Get me a list of the function who has reference to spin_lock()".
>
>  If I am writing a spin_lock checker.  I can look at who used spin_lock
>  and only load those functions as needed.
>  It is much better than scanning every single one of the kernel function to
>  search for the spin_lock function call.

That should be completely possible with both approaches. I don't see any
difference here.

>
> - The extra 4 bytes per structure storage on disk can be eliminated.
>  I agree you need some meta data to track the object before you dump
>  them to the file. But they don't need to be on the disk object at all.

Agreed. I'll rethink the implementation.

>
>  If you group same type of object together as an array. The index of the
>  object is implicit as the array index. If the C struct is fixed size. It is
>  trivial to locate the object.

This way, you don't have the transparency. You either need to load all the
data into memory, one structure after the other, and link them together,
basically going the same stuff dlopen() does for you,  or you'll need to
use special functions/macros to access the data from your checker.

>
>  If the C struct is variable size, currently on sparse each object knows
>  what size it is. You do need any index array to look it up. But this
>  array can be build on object loading time. They don't have to be on
>  the disk either.
>
>  Then you can get ride of the wrapper structure on the disk file format
>  all together.
>
>  The writer patch I send out use those tricks already. You are welcome to
>  poke around it.

I'm looking into it now. Thank you for sharing.

One crazy idea is... why can't we actually produce shared object binaries
directly... Maybe it won't be all that hard to generate valid ELF...
Just crazy probably.

>
> Chris
>
