From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: [PATCH 0/10] Sparse linker
Date: Fri, 5 Sep 2008 13:49:29 +0400
Message-ID: <f19298770809050249q48eac7d6oc02e8293ee6a163b@mail.gmail.com>
References: <1220478954-22678-1-git-send-email-alexey.zaytsev@gmail.com>
	 <f19298770809032103h5ea34122g44fda595d775cecf@mail.gmail.com>
	 <70318cbf0809040027i79476a4ds3d1086f5ca434d9d@mail.gmail.com>
	 <f19298770809040241h39703754i5bcac349e1d151c6@mail.gmail.com>
	 <70318cbf0809040335k5ea24032sffc11a8793b43b40@mail.gmail.com>
	 <f19298770809040629t1eb86f2co66a87e564bcd8684@mail.gmail.com>
	 <f19298770809040635s611ef3c3sa05111743ea60631@mail.gmail.com>
	 <70318cbf0809041204y75fa8f58vd6d1cfc7317b4fff@mail.gmail.com>
	 <f19298770809041321p53e81b93i6a6f62395b53af88@mail.gmail.com>
	 <70318cbf0809041424n1a773e0t3a68414a44ce79f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:25930 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbYIEJta (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 5 Sep 2008 05:49:30 -0400
Received: by rv-out-0506.google.com with SMTP id k40so377222rvb.1
        for <linux-sparse@vger.kernel.org>; Fri, 05 Sep 2008 02:49:29 -0700 (PDT)
In-Reply-To: <70318cbf0809041424n1a773e0t3a68414a44ce79f3@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>, Codrin Alexandru Grajdeanu <grcodal@gmail.com>

On Fri, Sep 5, 2008 at 1:24 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Thu, Sep 4, 2008 at 1:21 PM, Alexey Zaytsev <alexey.zaytsev@gmail.com> wrote:
>> Mostly ack here, but I still think the C code has two advantages over
>> binaries: It's easy to read, and it's an easy way to get the shared
>> library filled with the data, see below.
>
> It does not stop you to have some parsing tool to generate readable
> format from the object dump. But using the C source as primary way to
> dump object is letting the tail whack the dog. The on disk format should
> be optimized towards easy for checker rather than human to read it.
>
>> The huge disadvantage is the time and the memory it takes to compile
>> the C code.
>
> And the run time dependency of gcc.
>
>> Here I have to disagree. Loading the data from an .so might actually the
>> most evfficient method. See, the bulk of data of the .so is simply mmap'ed
>> read-only, with only the GOT being read-write, and when mapping with
>> RTLD_LAZY, the pointers are resolved only when you follow them, completely
>> transparently to us. You don't need the fine-grained control, the OS just does
>> the right thing for you. And if the checker needs to look at the bulk
>> of the data,
>
> Are you sure?
>
> Quote the man page:
> ===================
> RTLD_LAZY
>    Perform lazy binding. Only resolve symbols as the code that
> references them is executed. If the symbol is never referenced, then
> it is never resolved. (Lazy binding is only performed for function
> references; references to variables are always immediately bound when
> the library is loaded.)
> ===================
>
> Your symbol is store as DATA  nodes. Not functions. You never EXECUTE
> your sparse object code. The RTLD_LAZY has ZERO effect on them. All the symbol
> has to be immediately bounded. How can you tell which data pointer is lazy bound
> given that all the data value is possible in the pointer?
>

Confirmed, I was wrong.

>> it cat dlopen with RTLD_NOW. When multiple different checkers are being run
>> over the .so, the bulk of memory is shared between the processes, which I
>> think matters a lot. The memory is cheap, but now the number of cores
>> is growing.
>> E.g. if you've got 4 cores and 4 gigs of RAM, it's only one gig per
>> core, and wasting
>> 300 megabytes per process just to load the data doasn't look like a good idea.
>
> Even they are mmaped. Every symbol have to be touch up. So they need
> to swap in and COW. The COW memory can't be shared between process
> at all.  This is against the tradition of sparse being a small and neat tools.

And also here.
