From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm the LLVM IR for select instruction fails due to
 different types
Date: Sun, 19 Mar 2017 13:04:30 +0000
Message-ID: <CACXZuxeAaEGy25AmMky9GLrS0eetEg9O4dMTWk9TfB=Sm+Vc2A@mail.gmail.com>
References: <CACXZuxcGKmEbv=Umh26U=Uermy+n1f2A9_ZmBYJHE15WBYPFrw@mail.gmail.com>
 <20170319002145.4x3amj6bnb36yocj@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:35665 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbdCSNhD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 09:37:03 -0400
Received: by mail-it0-f44.google.com with SMTP id y18so8173496itc.0
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 06:37:02 -0700 (PDT)
In-Reply-To: <20170319002145.4x3amj6bnb36yocj@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 19 March 2017 at 00:21, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Tue, Mar 14, 2017 at 04:07:40PM +0000, Dibyendu Majumdar wrote:
>> LLVM complains when the operands of a select are not the same type. I
>> think it is okay to cast one of the operands to the type of the other
>> - on the basis that subsequent operations will cast things anyway.
>
> Submit a test case, please.
>

typedef union GCObject GCObject;
typedef union {
 GCObject *gc;
 void *p;
 int b;
} Value;
typedef struct lua_TValue {
 Value value;
 int tt;
} TValue;
typedef struct CClosure {
 GCObject *next;
 TValue upvalue[1];
} CClosure;
typedef struct LClosure {
 GCObject *next;
 GCObject *gclist;
} LClosure;
typedef union Closure {
 CClosure c;
 LClosure l;
} Closure;
static TValue luaO_nilobject_;
TValue *select(Closure *closure, int op)
{
 return op == 1 ? &closure->c.upvalue[0] : (TValue *) &luaO_nilobject_;
}
