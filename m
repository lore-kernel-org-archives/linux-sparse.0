From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm incorrect definition of local variables
Date: Thu, 9 Mar 2017 23:37:26 +0000
Message-ID: <CACXZuxfCq=GAGaeRbQZCEH98P2LzwkQKvMoN-CfPwUC678RXhA@mail.gmail.com>
References: <CACXZuxdH3tryp92DVHhd8zs9bUTbrAs92Pz+knnDqDzj4eXWYQ@mail.gmail.com>
 <20170307064436.qtcscbwbjsrjoyko@macpro.local> <CACXZuxcC-VPjB9CD0E9zUXp6XNS8v1DdvPUZ1vc88jqwYdFUhA@mail.gmail.com>
 <20170308065337.vwrebdlo4poc4da4@macpro.local> <CACXZuxcbDJAeRBN_wpTRPRk7efOM2vLytke=k_0f4=C0dOQtrA@mail.gmail.com>
 <CACXZuxeQO4p+J5MyggZhWJF9FfwnXHdG_wxx34jF3NFXqgd4Yg@mail.gmail.com>
 <20170309143513.pe7y5kuclabndyzu@macbook.local> <CACXZuxfjjCZuq-zDNEgoJcVj6ERPKMqU+nPZjbBHD_Dk+pVBCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:35219 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753950AbdCIXh2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Mar 2017 18:37:28 -0500
Received: by mail-it0-f41.google.com with SMTP id m27so78897001iti.0
        for <linux-sparse@vger.kernel.org>; Thu, 09 Mar 2017 15:37:27 -0800 (PST)
In-Reply-To: <CACXZuxfjjCZuq-zDNEgoJcVj6ERPKMqU+nPZjbBHD_Dk+pVBCQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 9 March 2017 at 23:30, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> On 9 March 2017 at 14:35, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> On Thu, Mar 09, 2017 at 01:50:16AM +0000, Dibyendu Majumdar wrote:
>>>
>>> I think by combining the symbol's identifier and address a unique
>>> reference can be created - thus whenever we encounter a symbol that is
>>> not extern or toplevel we should create a local object using the
>>> symbol's name + address as the LLVM identifier.
>>
>> That's more or less the idea, of course.
>> And you need to consider all objects that you don't need to
>> allocate because they are always in a (pseudo-) register.
>>
>
> This is my initial attempt at a fix. In the function pseudo_to_value()
> I modified the handling of PSEUDO_SYM. Note that I needed to add a new
> field 'priv' in the symbol structure (type void *) to hold the
> allocated value - there is an 'aux' field already for the backend to
> use but this is already used, so I wasn't sure whether there would be
> a conflict if I tried to reuse that field.
>

Also works with structs:

struct mytype {
 int a, b;
 double c;
};
extern void init(struct mytype *v);
int main(const char *argv[]) {

 int n = 0;
 {
  struct mytype x[5];
  init((struct mytype *)x);
  n += x[0].b;
 }
 {
  struct mytype x[6];
  init((struct mytype *)x);
  n += x[0].a;
 }
 return n;
}

%struct.mytype = type { i32, i32, double }
define i32 @main(i8**) {
L0:
  %x_000001A677EE7788 = alloca [6 x %struct.mytype]
  %x_000001A677EE7408 = alloca [5 x %struct.mytype]
  %R2 = bitcast [5 x %struct.mytype]* %x_000001A677EE7408 to %struct.mytype*
  call void @init(%struct.mytype* %R2)
  %1 = bitcast [5 x %struct.mytype]* %x_000001A677EE7408 to i32*
  %2 = bitcast i32* %1 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 4
  %4 = bitcast i8* %3 to i32*
  %load_target = load i32, i32* %4
  %R9 = bitcast [6 x %struct.mytype]* %x_000001A677EE7788 to %struct.mytype*
  call void @init(%struct.mytype* %R9)
  %5 = bitcast [6 x %struct.mytype]* %x_000001A677EE7788 to i32*
  %6 = bitcast i32* %5 to i8*
  %7 = getelementptr inbounds i8, i8* %6, i64 0
  %8 = bitcast i8* %7 to i32*
  %load_target1 = load i32, i32* %8
  %R13 = add i32 %load_target, %load_target1
  ret i32 %R13
}
declare void @init(%struct.mytype*)
