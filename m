From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH v2 00/27] LLVM fixes
Date: Sat, 11 Mar 2017 11:54:56 +0000
Message-ID: <CACXZuxcL4NHa2Ahdtu91rANDFTUw8hY9BizN-9pLgpyQ2wPf-w@mail.gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
 <CACXZuxc8rbcGSO9dTkFSKST8UJkDgc2ifFae5=Y+cojtm5qb3Q@mail.gmail.com> <20170311114903.zrhufw6ydneky3ya@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:38041 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755348AbdCKLy6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 06:54:58 -0500
Received: by mail-it0-f45.google.com with SMTP id m27so10036249iti.1
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 03:54:57 -0800 (PST)
In-Reply-To: <20170311114903.zrhufw6ydneky3ya@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>

On 11 March 2017 at 11:49, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sat, Mar 11, 2017 at 11:12:20AM +0000, Dibyendu Majumdar wrote:
>> We still cannot invoke
>> functions via pointers to functions using the (*ident)(arg) syntax due
>> to the incorrect load operation output by the linearizer.
>
> Yes, I'm working on it.
>
>> I have been trying to compile a smallish program (AVL Tree
>> implementation) - making progress but it still fails to compile, so I
>> will report the next issue!
>
> Good.
>

PSEUDO_VAL strikes again!

struct avl_node {
 struct avl_node *right;
 struct avl_node *left;
};
#define NULL ((void *)0)
static int test_null_comp(int height_changed, struct avl_node *node) {
 return node != NULL && height_changed;
}
