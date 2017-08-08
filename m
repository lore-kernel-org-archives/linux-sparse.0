From: Christopher Li <sparse@chrisli.org>
Subject: Re: Upcoming sparse release RC5
Date: Mon, 7 Aug 2017 21:34:41 -0400
Message-ID: <CANeU7QkU+GZA6J_B5SdZw0L=yvmYr_V=ue-h-TrZoWaGc-ATvg@mail.gmail.com>
References: <CANeU7QmZXY5Q4GmBMh42WpdiRyYfA=Ddpvjk_35=_Rmhb=RMiA@mail.gmail.com>
 <CAExDi1Qshm920Te38c-HZsrWDtxVS-WP6HRXkeNujWySXX0mXg@mail.gmail.com>
 <CANeU7QnY20n-UHY07RotcAJzFtMREB-CcsE1WXLi=b=cwQCizQ@mail.gmail.com>
 <CAExDi1QVtkoFCXzSoP0mg+3gbE45Z-bOGLAtjsTi8tsQZMdcEg@mail.gmail.com>
 <CANeU7Q=9Ma3+gA21+=bLi38XFw5B1FDoVFUvtaxLR3V0oHeCig@mail.gmail.com>
 <20170808002331.f3g6l7yzhsq3vhxe@ltop.local> <CANeU7QmJmzumvNNFm5W=Ti8TJdw-BZ2DeR0t2UXO-R2vCjqh6Q@mail.gmail.com>
 <CAExDi1R6Vg8cztVA32nOEHKRgpiUcZnHfOoK6rshJq46FSaj2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36678 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbdHHBen (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 21:34:43 -0400
Received: by mail-pf0-f178.google.com with SMTP id c28so8132910pfe.3
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 18:34:43 -0700 (PDT)
In-Reply-To: <CAExDi1R6Vg8cztVA32nOEHKRgpiUcZnHfOoK6rshJq46FSaj2g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 7, 2017 at 8:58 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Tue, Aug 8, 2017 at 2:42 AM, Christopher Li <sparse@chrisli.org> wrote:
>> On Mon, Aug 7, 2017 at 8:23 PM, Luc Van Oostenryck
>> <luc.vanoostenryck@gmail.com> wrote:
>>> If you don't mind, it would be nice if you could use the pull request
>>> I sent here: http://marc.info/?l=linux-sparse&m=150188507213269&w=4
>>> (you never saw it because I copy-pasted "[PATCH v3]" in the title of
>>> the cover page instead of using "[PATCH v4]" and so used the v3 and
>>> corrected the s/list/__list/ by hand).
>>> But it's not very important.
>>
>> I did not find that git pull url due to the V3 title. I did look for it.
>>
>> When I look at the patch, there is some compile error on one of the
>> patch (patch 4?). I just fix it by hand. I assume the git pull has the
>> same error because the patch are generated from git.
>>
>> I just checked, that compile error still on the git url you send out
>> in the email. I still can't use it
>
> Are you sure?
> in the link I pasted here above, the git branch is:
>
>     git://github.com/lucvoo/sparse.git fix-nested-pseudo-users-deletion-v4
>
>     aka: bddf7d1e4ed81c3def7c6de2796a5489ca678399


Yes, see the git log -p bddf7d1e4ed81c3def7c6de2796a5489ca678399


commit bddf7d1e4ed81c3def7c6de2796a5489ca678399
(luc/fix-nested-pseudo-users-deletion-v4)
Author: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date:   Fri Aug 4 21:50:20 2017 +0200

    mark pseudo users as deleted instead of removing them

    This will fix the (rare) problems with deletion while doing
    nested ptrlist walking that occurs when doing recursive
    kill_instruction() - remove_usage() - kill_instruction()

    Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

diff --git a/ptrlist.h b/ptrlist.h
index 1839b0f..78625c8 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -162,7 +162,7 @@ static inline void *last_ptr_list(struct ptr_list *list)
                        for (__nr = 0; __nr < __list->nr; __nr++) {
                 \
                                do {
                 \
                                        ptr = PTR_ENTRY(__list,__nr);
                 \
-                                       if (list->rm && !ptr)
                 \
+                                       if (__list->rm && !ptr)
                 \
                                                continue;
                 \
                                        do {

@@ -185,7 +185,7 @@ static inline void *last_ptr_list(struct ptr_list *list)
                        while (--__nr >= 0) {
                 \
                                do {
                 \
                                        ptr = PTR_ENTRY(__list,__nr);
                 \
-                                       if (list->rm && !ptr)
                 \
+                                       if (__list->rm && !ptr)
                 \
                                                continue;
                 \
                                        do {

That change is your later patch fixing the compile error in the previous
patch. I have to move this change into the previous patch.


>> Also, can you please give the pull request a dedicate branch,
>> like "for-chris",  not a tag? I don't want to pull from random branch
>> and end up merging between your topic branches.
>
> It won't change anything, in both case it's just a name for something
> (and using specific name for specific thing is a good thing I think)
> but no problem, it's fine for me.

You can still have your specific topic branch. I want a unified view
to pull from you.

It does change some thing. I find out that your like to just assign
the tag to the topic branch you want me to pull from. The last
"for-chris" tag might not be fast forwardable to the next "for-chris"
tag.

Think that "for-chris" as if your own luc-next. You can still maintain
a lot of topic branches. You aggregate the stable enough bits as luc-next
for others to try out. That is where I pull from, and I expect that
to be fast forwardable from master. The difference will be, you will
merge between your own branches before let me pull.

I don't need to keep track of what is the updated version of
different topic branches I have merged from you.

Currently, rebase the sparse-next with your topic branch pulled
is very tricky. I need to create a stable point for your aggregated
topic branches. That is equivalent of the "for-chris" branch on my
side. Then I rebase sparse-next on that.

If you maintain that "for-chris" to aggregate your own topic branch.
I can just use "for-chris" as a base to rease the sparse-next,
I only need to rebase patches not from you.

I do want to have the flexibility to rebase spase-next.
It is just how to do it in a way impact you less.

>> I often need to seek clarify if this patches series is mean for merge.
>> If you make that in the dedicate pull branch, I will know for sure.

Let me clarify that does not stop you from send out review with
specific topic branch.

I want a merged unified view from you to use as my base.

Chris
