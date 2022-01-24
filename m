Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F342BC433EF
	for <linux-sparse@archiver.kernel.org>; Mon, 24 Jan 2022 17:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiAXRWR (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:22:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240257AbiAXRWR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 24 Jan 2022 12:22:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643044936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i1S3g+b7br3s08Re9KUAkuBGZDRyz6Chv3XkAdUIT9o=;
        b=K5TK8qOAL64aHWJdT03HDw1iEYwSAXQ4MIYie3+uoJhS+MXoRtXOAIjbiLtOBZy7GnsXPI
        6N2jCBeK0a6EAd8gDOPt4nAXNfg1E1I0Vp0qj37DYiqeo5uhWlYMNO1gOaFUXXWIW26pp1
        8J6aPPfndLWQ3pXq5couYNpcL40qdIA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-QZXbErEhMhGUG7aVin8RtQ-1; Mon, 24 Jan 2022 12:22:07 -0500
X-MC-Unique: QZXbErEhMhGUG7aVin8RtQ-1
Received: by mail-qv1-f72.google.com with SMTP id ge15-20020a05621427cf00b00421df9f8f23so7588348qvb.17
        for <linux-sparse@vger.kernel.org>; Mon, 24 Jan 2022 09:22:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1S3g+b7br3s08Re9KUAkuBGZDRyz6Chv3XkAdUIT9o=;
        b=64aX6HQWiiU17WW7CkY6E20pbJto8NDOnQ7wd+pb4VjhBlscPGLINI47AW1SUh7SNX
         SzsGcGb6ol3t3LIMpSuC8syNehPzfVpVLb9vkrQ9JhlaM/1DMfQtjxkBrYnUvNlHaCGE
         ee7//M90KDCN14qHxfHUCeNWnEfv/O9G4L9b30dtYKiEmwcWWIpk+VwCCk3l3sD3ur8u
         9hrfSMMYzP1nZmfN4FlSnPFFzz0Ho7HbgrEs2gg8M9d4lm4+vqCsMXKB8SNFyqfsXgvg
         F3RuXD6IX8BpHqraAjtJbxSFiEbCtvk+dox6J2AGwCMKtkxkeR9x05Q1jb+h+BxZOCrR
         RkTw==
X-Gm-Message-State: AOAM530HAu7rr/+x5W96Sc+rDdlQc0+MzrN59o2Gt0sxDtP1GbtKZb3+
        Jjr6JvDb4wp9s1pTmHMxDFMj105ELJmszMZ1GPNcPdX0NAMM28Nme4cBYzXSzvc+zZw8p3BGNqY
        TPRTcf+ZE4arEX4fH9YWw3wkqE6IG/Xxv44ED3EL+
X-Received: by 2002:a37:bd86:: with SMTP id n128mr11660103qkf.770.1643044927254;
        Mon, 24 Jan 2022 09:22:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUimEDbi3foNski3m2mUz0H6FU6LVnCqDgmmWfF0KbAU4PZJm+/5jDqGBmK60YY0A94WZuVtb8Flw59Rfx47E=
X-Received: by 2002:a37:bd86:: with SMTP id n128mr11660087qkf.770.1643044927010;
 Mon, 24 Jan 2022 09:22:07 -0800 (PST)
MIME-Version: 1.0
References: <202201221028.YKA8kSdm-lkp@intel.com> <CAK-6q+h_hb94J3DSXPk=E44kCxiwZ+BE3kMJe09iShRzMb=vzQ@mail.gmail.com>
 <91901e7b-7d82-116c-aaf2-c74c6a6b999c@infradead.org> <CAK-6q+j2jc3pBmbvQ-DCmxveC-UMV75SFc2nC1zwXKe9wm4YPg@mail.gmail.com>
 <20220124124530.GS1951@kadam>
In-Reply-To: <20220124124530.GS1951@kadam>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 24 Jan 2022 12:21:55 -0500
Message-ID: <CAK-6q+iZfY=FyOxJfS7cY7MqScs+nU=U3B4NnLnvcLH3fofuAg@mail.gmail.com>
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

On Mon, Jan 24, 2022 at 7:46 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Sun, Jan 23, 2022 at 01:41:52PM -0500, Alexander Aring wrote:
> >
> > I see also:
> >
> > fs/dlm/midcomms.c:213:1: sparse: sparse: symbol
> > '__srcu_struct_nodes_srcu' was not declared. Should it be static?
> >
>
> Why not just do this?  (Untested.  Maybe I don't understand?)
>
> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index cb1f4351e8ba..a164089abec4 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -121,7 +121,7 @@ struct srcu_struct {
>  #ifdef MODULE
>  # define __DEFINE_SRCU(name, is_static)                                        \
>         is_static struct srcu_struct name;                              \
> -       struct srcu_struct * const __srcu_struct_##name                 \
> +       is_static struct srcu_struct * const __srcu_struct_##name       \
>                 __section("___srcu_struct_ptrs") = &name
>  #else
>  # define __DEFINE_SRCU(name, is_static)                                        \
>

I tried it and yes it will fix the issue and introduce another one
about "is_static struct srcu_struct * const __srcu_struct_##name" is
unused ("-Wunused-const-variable").
I added a __maybe_unused after the introduced is_static and it seems
to fix the introduced issue, now it compiles and sparse is happy. I am
not sure if this is the right fix?

- Alex

