From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Thu, 2 Mar 2017 14:33:09 +0000
Message-ID: <CACXZuxeiWM9zJZqtUC1YN6tFO6VsHkfTn9CZefr6P5nYUOpoRA@mail.gmail.com>
References: <CACXZuxdav6y9uRC9mavNkVZS173k0ftw-8FpPanKLsoF-ws0Sw@mail.gmail.com>
 <20170228150956.moyfiyd5zf7tbeze@macbook.local> <CAExDi1Sa3zDs--jht_43EmefT_nj5ThO_-QRdAFZJn=+rAw0iQ@mail.gmail.com>
 <CACXZuxeRe1Oe-Anht7hnsZgwZroP8sZdajvLBdO3oYCE1ofZ8Q@mail.gmail.com>
 <CACXZuxd2fO7-i84+nS5sC7ZHC68=_uJX3P9k75z05Y8vy2BAUA@mail.gmail.com>
 <20170302052124.fsqogvysufayy4to@macbook.local> <CACXZuxe_+-8H6SSA0NvpUdchWYzo_v=2KJq61QC9cVNYG3DGkQ@mail.gmail.com>
 <20170302135655.s742zcslis5r56if@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:37675 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752624AbdCBOeg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Mar 2017 09:34:36 -0500
Received: by mail-it0-f49.google.com with SMTP id 203so52336837ith.0
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 06:33:10 -0800 (PST)
In-Reply-To: <20170302135655.s742zcslis5r56if@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 2 March 2017 at 13:56, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Thu, Mar 02, 2017 at 05:41:59AM +0000, Dibyendu Majumdar wrote:
>> On 2 March 2017 at 05:21, Luc Van Oostenryck
>> <luc.vanoostenryck@gmail.com> wrote:
>> >> Anyway have hit a bunch of other issues with sparse-llvm ... :-(
>> >
>> > Each day its problem (and happily its solution too!).
>> >
>>
>> I will submit test cases for the new problems when I get some time.
>

Below is an example that fails for me. I am running a modified version
of Sparse although the modifications are to do with a) removing global
state and b) compiling with Visual C++ on Windows 10 - and all sparse
tests pass so I don't think they have anything to do with the failure
here. I do have Linux build of sparse but without LLVM so I will need
to sort that out to test. Anyway, I would be interested to know if you
get a failure (you will need to have LLVM assertions enabled).

typedef unsigned long long size_t;
struct buffer_type_st {
 struct buffer_type_st    *next_buffer;
 char           *buffer;
};
typedef struct buffer_type_st buffer_type_t;
struct link_st {
 struct link_st           *next;
};
typedef struct link_st link_t;
struct allocator_st {
 buffer_type_t    *buffer_list;
 link_t           *free_list;
 char           *next_avail;
 char           *last;
 size_t          size;
 size_t          n;
};
typedef struct allocator_st allocator;
extern void
grow_allocator(allocator * a);
extern void *
malloc(size_t size);
void
grow_allocator(allocator * a)
{
 buffer_type_t    *tmp;
 tmp = (buffer_type_t *) malloc(sizeof(buffer_type_t));
 tmp->buffer = (char *) malloc(a->size * a->n);
 tmp->next_buffer = a->buffer_list;
 a->buffer_list = tmp;
 a->next_avail = a->buffer_list->buffer;
 a->last = a->next_avail + (a->size * a->n);
}


The failure occurs in the line:

 a->next_avail = a->buffer_list->buffer;

I am guessing it has to do with the nested member access but I have
not yet been able to work out what the code is doing.

LLVM gives me following error:

Assertion failed: S->getType()->isPtrOrPtrVectorTy() && "Invalid
cast", file C:\d\llvm-3.9.0.src\lib\IR\Instructions.cpp, line 2759

This occurs in calc_memop_addr() function when it tries to do following:

 as = LLVMGetPointerAddressSpace(LLVMTypeOf(src));

If I dump insn, insn->src, and the LLVM value and type before this line, I get:

1) insn load.64     %r18 <- 8[%r2]
2) pseudo %r2
3) store %struct.buffer_type_st* %R2, %struct.buffer_type_st** %26
4) void

The type of the LLVM store instruction is 'void'.

My guess is that something is going horribly wrong in the way member
access is handled.

If you are able to reproduce this and have any suggestions then please
let me know.

Thanks and Regards
Dibyendu
