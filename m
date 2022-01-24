Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A908C433F5
	for <linux-sparse@archiver.kernel.org>; Mon, 24 Jan 2022 17:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241435AbiAXRgU (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:36:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35022 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241177AbiAXRgT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 24 Jan 2022 12:36:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643045779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WjBDf6aQrfObbBjTLFtxuNqmDl1jBGQg6+6y9Yi96mM=;
        b=GIRY+anpJt0g7K1AFZmKF/6qNhfyrZjGb2uA+5yC9i7KVN4EVtWbWJ8PbNRhEqR/5/rkBj
        R2as345f8KnbcJwX5a63ysK6O5X52w5PMHjqeSoURb5GG29CWcQrLoYBltEQHXqcFgt7dV
        OxUK/s48QSu7LkMBLjuSHVEZkmq28xo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-Xw_P1JPrPM6rM7h-8yfk6Q-1; Mon, 24 Jan 2022 12:36:18 -0500
X-MC-Unique: Xw_P1JPrPM6rM7h-8yfk6Q-1
Received: by mail-qk1-f197.google.com with SMTP id q5-20020a05620a0d8500b004738c1b48beso12798931qkl.7
        for <linux-sparse@vger.kernel.org>; Mon, 24 Jan 2022 09:36:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WjBDf6aQrfObbBjTLFtxuNqmDl1jBGQg6+6y9Yi96mM=;
        b=rRoFVT7Um6sGja5Oob9pgodCIpRpws9JI0gmVOvHXD59iKIqPiDJDsC7O/YHY+XbV/
         ivv/28K+z0CktNBGKYkN247MXTRmdpa1ifS/1BG2xdzWLOZbAX65SBs3DTMsak0xkshl
         rPnvKepdhwfpOH88E0tpRtvqHzK4iRYndn7CWWrFaJHveERuBO5y7MBp9yT+v1J1wcDg
         jBsXXVSAThZVmxFPR8EH7c4ZWBPJdz4LR+GVGPqg9RgwXAZS8jCyyTR5Ob1xFRlG6Cxo
         AEMx3zCUIfSPsgJrwBsxtdzxa9e8DN2I/5rbb1TOLFVY7mFZ/vgRAcdRk3n4VFMaVKA9
         28Pw==
X-Gm-Message-State: AOAM531FR9fRhlH9V5xOgZ7GmOpn/saILloyLql1WvPlotO311GGnmeV
        d2a6Qtq1c2SjhZk9Np4eDLzF4kJe7/YDYKCfe1L3qFGcO3+fEushjs+HhpP0DBSlS3eHjjtgdUY
        lPIfRzeYfJdWCbo0XtrX0XmEx3Ch78vkxtW6a88uJ
X-Received: by 2002:a05:622a:154:: with SMTP id v20mr13313797qtw.291.1643045777220;
        Mon, 24 Jan 2022 09:36:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzekCkfE92GPinXMJeJVNleUpPXFDuFcVsiLj6BYCwesW3YBTj4opk1FKA8tMEDl+ZjXtRSE5Ok2D2HOBmeptY=
X-Received: by 2002:a05:622a:154:: with SMTP id v20mr13313769qtw.291.1643045776895;
 Mon, 24 Jan 2022 09:36:16 -0800 (PST)
MIME-Version: 1.0
References: <202201221028.YKA8kSdm-lkp@intel.com> <CAK-6q+h_hb94J3DSXPk=E44kCxiwZ+BE3kMJe09iShRzMb=vzQ@mail.gmail.com>
 <91901e7b-7d82-116c-aaf2-c74c6a6b999c@infradead.org> <CAK-6q+j2jc3pBmbvQ-DCmxveC-UMV75SFc2nC1zwXKe9wm4YPg@mail.gmail.com>
 <20220124124530.GS1951@kadam> <CAK-6q+iZfY=FyOxJfS7cY7MqScs+nU=U3B4NnLnvcLH3fofuAg@mail.gmail.com>
In-Reply-To: <CAK-6q+iZfY=FyOxJfS7cY7MqScs+nU=U3B4NnLnvcLH3fofuAg@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 24 Jan 2022 12:36:06 -0500
Message-ID: <CAK-6q+ga2zT2h4oY0=aCXFeU=oaFHbSXGzuVRptB8Hg-YKR7Gw@mail.gmail.com>
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

On Mon, Jan 24, 2022 at 12:21 PM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi,
>
> On Mon, Jan 24, 2022 at 7:46 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Sun, Jan 23, 2022 at 01:41:52PM -0500, Alexander Aring wrote:
> > >
> > > I see also:
> > >
> > > fs/dlm/midcomms.c:213:1: sparse: sparse: symbol
> > > '__srcu_struct_nodes_srcu' was not declared. Should it be static?
> > >
> >
> > Why not just do this?  (Untested.  Maybe I don't understand?)
> >
> > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > index cb1f4351e8ba..a164089abec4 100644
> > --- a/include/linux/srcutree.h
> > +++ b/include/linux/srcutree.h
> > @@ -121,7 +121,7 @@ struct srcu_struct {
> >  #ifdef MODULE
> >  # define __DEFINE_SRCU(name, is_static)                                        \
> >         is_static struct srcu_struct name;                              \
> > -       struct srcu_struct * const __srcu_struct_##name                 \
> > +       is_static struct srcu_struct * const __srcu_struct_##name       \
> >                 __section("___srcu_struct_ptrs") = &name
> >  #else
> >  # define __DEFINE_SRCU(name, is_static)                                        \
> >
>
> I tried it and yes it will fix the issue and introduce another one
> about "is_static struct srcu_struct * const __srcu_struct_##name" is
> unused ("-Wunused-const-variable").
> I added a __maybe_unused after the introduced is_static and it seems
> to fix the introduced issue, now it compiles and sparse is happy. I am
> not sure if this is the right fix?

it is obviously unused, but it has something to do with
"__section("___srcu_struct_ptrs")" and during module loading it, I
suppose, srcu tries to access it to find whatever needs to be
registered?

- Alex

