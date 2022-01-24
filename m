Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCD0C433EF
	for <linux-sparse@archiver.kernel.org>; Mon, 24 Jan 2022 22:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380807AbiAXWHv (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 24 Jan 2022 17:07:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351325AbiAXVhL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 24 Jan 2022 16:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643060229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c7q48nDqJH52nwasKn4MU6PTMavVxq2H/SkUyJ4E2Gc=;
        b=Mchf8LTkYEWnC+U3UVe1TA5pzdgjKU+b7bE9GBjCIihN4msLDLIwiToHzqrn1eaXVVD1JR
        Bd2MOXC9W234ZUX0+M/BmLsqVzFHhIu+hYAVaqLmayNKv102GttYd9998tVgOYgvA7Psw9
        iGLw8LqhYDqWX+Ka5wqNZYfFc0SVdqw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-Bb9Oy8IGNGKnCGdX_Gy_jg-1; Mon, 24 Jan 2022 16:37:06 -0500
X-MC-Unique: Bb9Oy8IGNGKnCGdX_Gy_jg-1
Received: by mail-qt1-f198.google.com with SMTP id 4-20020ac85744000000b002b2f329efc2so10622960qtx.12
        for <linux-sparse@vger.kernel.org>; Mon, 24 Jan 2022 13:37:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c7q48nDqJH52nwasKn4MU6PTMavVxq2H/SkUyJ4E2Gc=;
        b=0yNiWS9vOeaiZ+NPw7ds02t4olQuGJrWgrntWu9WREryLfWlvCuuPRiOciNsTXArB7
         IK2n+z/vLakAkO4kYMJwHiHotpxdokbPFDVUIjzs2dSyJzrwqxjZ0szX04niOW41tdNd
         9Bg9pkmaGR+kAZGAT5F1Akxjgny6z792K08ruz+9xNpxve7IphjdMWSQSAUJxr5Y3g9n
         5tw8ZQFR1jzBColAJrBGocOeRlcqPS/AGV9Huhg0Nj445GNCvEpbCF5LXat5eYP25BtJ
         /pzKqRHALPb5W792r/PVNKg++SRwX/W0eD8uJ0Q8WKgy2NupTeGDi7Lo5Sfhclad8h3/
         pcPg==
X-Gm-Message-State: AOAM530TKW818VbTPK1cWgekuDEsw54nogTCJJ+7nwQOLdrhbgpFRyaZ
        Nqhx+NAbpS/LiB0kHjeaHptxxnnxamR1uTqFHpZR53G9s5XYxi38+jz83WVg7HXC/Eb1zewcjeP
        DXtqkv2CMk4vsrrz4pjehTO0RnQ1itaKXg1ieRxuD
X-Received: by 2002:a05:622a:2ce:: with SMTP id a14mr160155qtx.470.1643060226387;
        Mon, 24 Jan 2022 13:37:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxENcHQBykB+R71peyKNCWZlQR8fLwfIUcwHCuHFtkiFmn2NGP2p8g1zWvx7XU2anZ1AcJ8P5lqh/+uhv6oDxE=
X-Received: by 2002:a05:622a:2ce:: with SMTP id a14mr160117qtx.470.1643060225927;
 Mon, 24 Jan 2022 13:37:05 -0800 (PST)
MIME-Version: 1.0
References: <202201221028.YKA8kSdm-lkp@intel.com> <CAK-6q+h_hb94J3DSXPk=E44kCxiwZ+BE3kMJe09iShRzMb=vzQ@mail.gmail.com>
 <91901e7b-7d82-116c-aaf2-c74c6a6b999c@infradead.org> <CAK-6q+j2jc3pBmbvQ-DCmxveC-UMV75SFc2nC1zwXKe9wm4YPg@mail.gmail.com>
 <20220124124530.GS1951@kadam> <CAK-6q+iZfY=FyOxJfS7cY7MqScs+nU=U3B4NnLnvcLH3fofuAg@mail.gmail.com>
 <CAK-6q+ga2zT2h4oY0=aCXFeU=oaFHbSXGzuVRptB8Hg-YKR7Gw@mail.gmail.com>
 <CAK-6q+jfA2k1TFrLqK4YN2vshgLidD=6r_CCV6df_VRFMFO7ag@mail.gmail.com> <20220124201417.GI4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220124201417.GI4285@paulmck-ThinkPad-P17-Gen-1>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 24 Jan 2022 16:36:55 -0500
Message-ID: <CAK-6q+gGx68Wx8mBJAdo0ygpBWPoHW+L+HD11U6UQSOjSXVP3w@mail.gmail.com>
Subject: Re: fs/dlm/midcomms.c:913:22: sparse: sparse: restricted __le32
 degrades to integer
To:     paulmck@kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
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

On Mon, Jan 24, 2022 at 3:23 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Jan 24, 2022 at 12:41:04PM -0500, Alexander Aring wrote:
> > Hi,
> >
> > On Mon, Jan 24, 2022 at 12:36 PM Alexander Aring <aahringo@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, Jan 24, 2022 at 12:21 PM Alexander Aring <aahringo@redhat.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Mon, Jan 24, 2022 at 7:46 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > > >
> > > > > On Sun, Jan 23, 2022 at 01:41:52PM -0500, Alexander Aring wrote:
> > > > > >
> > > > > > I see also:
> > > > > >
> > > > > > fs/dlm/midcomms.c:213:1: sparse: sparse: symbol
> > > > > > '__srcu_struct_nodes_srcu' was not declared. Should it be static?
> > > > > >
> > > > >
> > > > > Why not just do this?  (Untested.  Maybe I don't understand?)
> > > > >
> > > > > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > > > > index cb1f4351e8ba..a164089abec4 100644
> > > > > --- a/include/linux/srcutree.h
> > > > > +++ b/include/linux/srcutree.h
> > > > > @@ -121,7 +121,7 @@ struct srcu_struct {
> > > > >  #ifdef MODULE
> > > > >  # define __DEFINE_SRCU(name, is_static)                                        \
> > > > >         is_static struct srcu_struct name;                              \
> > > > > -       struct srcu_struct * const __srcu_struct_##name                 \
> > > > > +       is_static struct srcu_struct * const __srcu_struct_##name       \
> > > > >                 __section("___srcu_struct_ptrs") = &name
> > > > >  #else
> > > > >  # define __DEFINE_SRCU(name, is_static)                                        \
> > > > >
> > > >
> > > > I tried it and yes it will fix the issue and introduce another one
> > > > about "is_static struct srcu_struct * const __srcu_struct_##name" is
> > > > unused ("-Wunused-const-variable").
> > > > I added a __maybe_unused after the introduced is_static and it seems
> > > > to fix the introduced issue, now it compiles and sparse is happy. I am
> > > > not sure if this is the right fix?
> > >
> > > it is obviously unused, but it has something to do with
> > > "__section("___srcu_struct_ptrs")" and during module loading it, I
> > > suppose, srcu tries to access it to find whatever needs to be
> > > registered?
> >
> > Sorry, but if this is true then it can't be declared as static... and
> > we are at the beginning again.
>
> Welcome to my world!!!  ;-)
>
> More seriously, thank you for chasing this down.  But would it work to
> add a declaration just before?
>

only if I add an "extern" in front of the declaration before, so it looks like:

extern struct srcu_struct * const __srcu_struct_##name;

(compile and sparse tested only)

- Alex

