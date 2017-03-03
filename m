From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH] llvm: fix output_op_[ptr]cast()
Date: Fri, 3 Mar 2017 19:54:23 +0000
Message-ID: <CACXZuxdr8HiVb=BsA3cZJEAUa3Dqd0OXe4N84djM1tVaDveMEw@mail.gmail.com>
References: <CACXZuxcd6q6c5VzsYME01nzUhKzLjzvxTDt3juSbNB226APTTg@mail.gmail.com>
 <20170303052459.2351-1-luc.vanoostenryck@gmail.com> <CACXZuxcN_5H+Ur53axpwbxy-LwQX2fANp5x6GUU-jU+7b4_2tw@mail.gmail.com>
 <CACXZuxd_gY9uaDHiCzq1TqRweeyp22ifWDDYZbYmjnMkGohenw@mail.gmail.com> <CAExDi1RtFcCkdaWJ10o9p22BZcB5GcsbKmxCBDn5vMmkoBVZTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:37902 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbdCCUSZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 3 Mar 2017 15:18:25 -0500
Received: by mail-it0-f42.google.com with SMTP id m27so20221209iti.1
        for <linux-sparse@vger.kernel.org>; Fri, 03 Mar 2017 12:18:24 -0800 (PST)
In-Reply-To: <CAExDi1RtFcCkdaWJ10o9p22BZcB5GcsbKmxCBDn5vMmkoBVZTg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 3 March 2017 at 19:50, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Fri, Mar 3, 2017 at 7:06 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> The problem occurs in this sequence:
>>
>>        ptrcast.64  %r26 <- (64) %r20
>>        add.64      %r27 <- %r26, %r23
>>        cast.64     %r28 <- (64) %r27
>>        store.64    %r28 -> 16[%arg1]
>>
>> The last cast finds that the instruction type in an integer and does a
>> cast to Integer, so that causes the store to fail as it expects a
>> pointer.
>
> What is the corresponding C code?
> With the patches I've posted, the three example you've given are handled
> without error for me.
>

C code below, it is the last += that is failing.

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
extern void *
alloc_node(allocator * a);
extern void
grow_allocator(allocator * a);
void *
alloc_node(allocator * a)
{
 link_t           *tmp;
 tmp = a->free_list;
 if (a->free_list) {
  a->free_list = (link_t *) (a->free_list->next);
  return (void *) tmp;
 } else {
  if (a->next_avail == a->last) {
   grow_allocator(a);
  }
  {
   void           *tmp;
   tmp = (void *) a->next_avail;
   a->next_avail += a->size;
   return tmp;
  }
 }
}
