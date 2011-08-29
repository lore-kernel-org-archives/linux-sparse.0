From: Christopher Li <sparse@chrisli.org>
Subject: Re: [ANNOUNCE] LLVM backend for Sparse
Date: Mon, 29 Aug 2011 02:19:27 -0700
Message-ID: <4E5B599F.4090205@chrisli.org>
References: <alpine.DEB.2.00.1108280904070.7603@localhost6.localdomain6> <CANeU7Q=PUDGGm9G6PnXvW3QeBnnMP39mfEE=HvszvBeAvrA4yQ@mail.gmail.com> <alpine.DEB.2.00.1108281700030.7991@localhost6.localdomain6> <CA+55aFymNRxwWMVPwhWKGB7T2UXduGccjW1FgKYGCb8QH9QAhg@mail.gmail.com> <CAOJsxLE-3CLPrLhphaVLs6CoWi0JYA02=Ny_fRrn8wqS2o0NcQ@mail.gmail.com>
Reply-To: sparse@chrisli.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:65412 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260Ab1H2JTl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Aug 2011 05:19:41 -0400
Received: by pzk37 with SMTP id 37so8141983pzk.1
        for <linux-sparse@vger.kernel.org>; Mon, 29 Aug 2011 02:19:41 -0700 (PDT)
In-Reply-To: <CAOJsxLE-3CLPrLhphaVLs6CoWi0JYA02=Ny_fRrn8wqS2o0NcQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Josh Triplett <josh@joshtriplett.org>

On 08/29/2011 12:41 AM, Pekka Enberg wrote:
> Right. Will the "link time constant" 'struct symbol' be part of the 
> symbol_list? If it is, then we already do LLVMAddGlobal in 
> output_data() on it and could probably just stash that into a ->priv 
> member in 'struct symbol' and use that in pseudo_to_value(). 

The link time constant is a LLVMValueRef, it is just the address of the 
symbol.
Yes, it will belong to the function scope's symbol_list but not 
necessary the global one.
Here is some tips that help me a lot on my own llvm branch, which lost 
due to a hard
drive crash. It was able to do hello world back then.

LLVM can output c++ source code that construct the llvm byte code.

# this will emit hello.s as the llvm asm code
$ clang -S -emit-llvm hello.c

# this will generate hello.s.cpp which is the c++ source code to construct
# the llvm byte code above

$ llc -march=cpp hello.s

The hello.s.cpp is a very good reference to build the llvm byte code in C.
It is in C++, but convert to llvm C binding should be easy.
BTW, "-march=c" does not generate C bindings, it generate the
equivalent IR in C code instead.

Hope that helps.

Chris



