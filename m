Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084E5C433EF
	for <linux-sparse@archiver.kernel.org>; Mon, 24 Jan 2022 17:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244694AbiAXRlS (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:41:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244591AbiAXRlR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 24 Jan 2022 12:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643046076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KLmnh7F+9qnrIKW2UFS2DJy4bOHo/tjVCSEI8rXwkN0=;
        b=KUj3Ye52w/EyCg8CoDKt5xipQYmwbSPg8uTzWgk4r+ssEJQWKd3fMo/QxziVRoy6dQ7BOI
        96ImPMkErurODfyIGT5K2R662csC+VrYVTjBhq+qOEGG0TJC3FMEohUvcAXymJMQLrNCQ1
        jo9WycFYVLt5JG71ruvJkt3l8tIgySc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-Esb8wN18ObGyFMyxbo0qSA-1; Mon, 24 Jan 2022 12:41:15 -0500
X-MC-Unique: Esb8wN18ObGyFMyxbo0qSA-1
Received: by mail-qk1-f199.google.com with SMTP id o3-20020a375a03000000b0047bc1e51002so12800334qkb.19
        for <linux-sparse@vger.kernel.org>; Mon, 24 Jan 2022 09:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLmnh7F+9qnrIKW2UFS2DJy4bOHo/tjVCSEI8rXwkN0=;
        b=aeRZnpaJiS8qK1aU+8Sj3W/v8b5tM53+PvSMPVUqcQMi9sNT1qeH1IRFXRAqciDXVq
         GNvP1J8ZophA7My6z/KfI4EInN7pr1h0FNZu7WCaZ4wIqZKe9BwEdrJScI0dZAJ8Q8we
         1G0jjp1MK59iZUZ2RxgnI83uoS0cM/KP6FAlO1/A/5rE9UvnFbpaPqe7O2L/p4zvaUmp
         WnLMtvFOERtWP4yAfKQbeQk0cERNyJStUXThfRe2gOpHP+aET6Ebox5/yQ3zzw0pHQ9a
         ofUQ9twvHU3EhPB48HcgjvtxwsBHkRZXlQyhn/uk9LB+EyKWnvlgMJcaYCu5z5SrWasK
         B2aA==
X-Gm-Message-State: AOAM530SPhA9YhvUQCgnhno37QxQl9o5k/Bfy4sQLJcjQtXKWC5LSC8P
        7skTZinyMi88KYvJfmVOZ6VW7Xqw7QMiUpqjCPcnljO9S5JUnrhODBsz8UrZbZQDAEh4iJXDKgY
        biR4MbaB8fZt03U48NNaAERjvw4YuEuffrtXQsZ1n
X-Received: by 2002:a05:6214:21ae:: with SMTP id t14mr5881005qvc.59.1643046075064;
        Mon, 24 Jan 2022 09:41:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmZ0zoLxqMaj4sgRawFKfYQmeh7BxLZQUfotyGdGqOmghwyprTfohZ9jYN68ECfTUFCiv5VLMuukYTQwYO+9A=
X-Received: by 2002:a05:6214:21ae:: with SMTP id t14mr5880983qvc.59.1643046074838;
 Mon, 24 Jan 2022 09:41:14 -0800 (PST)
MIME-Version: 1.0
References: <202201221028.YKA8kSdm-lkp@intel.com> <CAK-6q+h_hb94J3DSXPk=E44kCxiwZ+BE3kMJe09iShRzMb=vzQ@mail.gmail.com>
 <91901e7b-7d82-116c-aaf2-c74c6a6b999c@infradead.org> <CAK-6q+j2jc3pBmbvQ-DCmxveC-UMV75SFc2nC1zwXKe9wm4YPg@mail.gmail.com>
 <20220124124530.GS1951@kadam> <CAK-6q+iZfY=FyOxJfS7cY7MqScs+nU=U3B4NnLnvcLH3fofuAg@mail.gmail.com>
 <CAK-6q+ga2zT2h4oY0=aCXFeU=oaFHbSXGzuVRptB8Hg-YKR7Gw@mail.gmail.com>
In-Reply-To: <CAK-6q+ga2zT2h4oY0=aCXFeU=oaFHbSXGzuVRptB8Hg-YKR7Gw@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 24 Jan 2022 12:41:04 -0500
Message-ID: <CAK-6q+jfA2k1TFrLqK4YN2vshgLidD=6r_CCV6df_VRFMFO7ag@mail.gmail.com>
Subject: Re: fs/dlm/midcomms.c:913:22: sparse: sparse: restricted __le32
 degrades to integer
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, David Teigland <teigland@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-sparse@vger.kernel.org, rcu@vger.kernel.org
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=aahringo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi,

On Mon, Jan 24, 2022 at 12:36 PM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi,
>
> On Mon, Jan 24, 2022 at 12:21 PM Alexander Aring <aahringo@redhat.com> wrote:
> >
> > Hi,
> >
> > On Mon, Jan 24, 2022 at 7:46 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > On Sun, Jan 23, 2022 at 01:41:52PM -0500, Alexander Aring wrote:
> > > >
> > > > I see also:
> > > >
> > > > fs/dlm/midcomms.c:213:1: sparse: sparse: symbol
> > > > '__srcu_struct_nodes_srcu' was not declared. Should it be static?
> > > >
> > >
> > > Why not just do this?  (Untested.  Maybe I don't understand?)
> > >
> > > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > > index cb1f4351e8ba..a164089abec4 100644
> > > --- a/include/linux/srcutree.h
> > > +++ b/include/linux/srcutree.h
> > > @@ -121,7 +121,7 @@ struct srcu_struct {
> > >  #ifdef MODULE
> > >  # define __DEFINE_SRCU(name, is_static)                                        \
> > >         is_static struct srcu_struct name;                              \
> > > -       struct srcu_struct * const __srcu_struct_##name                 \
> > > +       is_static struct srcu_struct * const __srcu_struct_##name       \
> > >                 __section("___srcu_struct_ptrs") = &name
> > >  #else
> > >  # define __DEFINE_SRCU(name, is_static)                                        \
> > >
> >
> > I tried it and yes it will fix the issue and introduce another one
> > about "is_static struct srcu_struct * const __srcu_struct_##name" is
> > unused ("-Wunused-const-variable").
> > I added a __maybe_unused after the introduced is_static and it seems
> > to fix the introduced issue, now it compiles and sparse is happy. I am
> > not sure if this is the right fix?
>
> it is obviously unused, but it has something to do with
> "__section("___srcu_struct_ptrs")" and during module loading it, I
> suppose, srcu tries to access it to find whatever needs to be
> registered?

Sorry, but if this is true then it can't be declared as static... and
we are at the beginning again.

- Alex

