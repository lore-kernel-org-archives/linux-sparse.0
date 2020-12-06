Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B80C4361B
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Dec 2020 00:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC0222E03
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Dec 2020 00:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgLFAOi (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 5 Dec 2020 19:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgLFAOh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Dec 2020 19:14:37 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD15C0613D1;
        Sat,  5 Dec 2020 16:13:57 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id lt17so14210331ejb.3;
        Sat, 05 Dec 2020 16:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3IgKPEXPEhoiVhProzrF1Nh2SnPmElxALGug4CytgfI=;
        b=Gle+JDe8dq1mS9tatLrCtwEHambE00p2187JymYCoH3f4Ao7io13hqwYvA2oCxuA30
         XN+Kv/br6c3CHYzBS2xX7UKSwHQR72yGJCvMXQ6L9VR9to9CXUhvPkezsEzuOvRtYc1I
         6Qn6EKFgSNKrrv+9eIoFMFdIwkwdNRlb8YwhYsICb79J8D+C6P4426y2xlola7XpXYCn
         wxgax4SvOaLyX/VhESfmoI781HXHWwfzabJgCd6TB5/PW8gA57FnJf2d6Eg88ewZ68ye
         L50i5Wue1Nwy+fJ+psrEc4YKRKlJxqXmWZBxHLMX06Os9FMIevT4Q6KnsgTdg8tRmP/r
         wRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3IgKPEXPEhoiVhProzrF1Nh2SnPmElxALGug4CytgfI=;
        b=oL3EaXq3F1Viz5OMdDeUbd/nMs5anq0gBgLVXJPzg4wgf0af5nPkgMLPfuXSnHz30G
         YZQR/Jp+JzttBr6OyK7Q15p31M4THjkYiRuuzCXMYK0bd1Ut9MCBHKFx1SxCgJKTMtLW
         zyUzgHFMXRYHDXenvbGSeAeHyTKhO0o/s4wKqizmD2an5sdWX8XQgZ5Y7UJoItfNw1JD
         RmdDCSKUVirB+Z0Ylnpe+exrMYgb9PBj7im2TBZy7ufjMZI9M1z+CTy3sWF4X7qZorXb
         W3pKBD0W+TWLkrgpC0p3DqI2ahxewe+kHXYSF+WMsWf9PI8zmLe3JzM235z7WBISwLu8
         mGcA==
X-Gm-Message-State: AOAM53302snKS2/CLtme+FTHcvr65UQxFSKaVtkUVSLF90zqJs4EnTx2
        rSqA5KRAaCD5X1gp2tNGWRg=
X-Google-Smtp-Source: ABdhPJzdddZB84HMqvCk/h7GloMp+rVVHoftPjacD2sZTy7yG/PM1g9Ak8rt3+nLxxCWv/u0C7GxmA==
X-Received: by 2002:a17:906:4050:: with SMTP id y16mr12774577ejj.537.1607213635882;
        Sat, 05 Dec 2020 16:13:55 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:78c1:dc3d:b5fd:9b12])
        by smtp.gmail.com with ESMTPSA id gl2sm6390263ejb.29.2020.12.05.16.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 16:13:54 -0800 (PST)
Date:   Sun, 6 Dec 2020 01:13:53 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        edwin.peer@broadcom.com,
        Zhang Changzhong <zhangchangzhong@huawei.com>
Subject: Re: sparse annotation for error types?
Message-ID: <20201206001353.fhfu6wzn7nfg7fmv@ltop.local>
References: <20201205143250.2378b9f9@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <CAHk-=wjQYjRusiGfXTywSg5xC8knhP6uesDfO3J=bgu5uevtyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjQYjRusiGfXTywSg5xC8knhP6uesDfO3J=bgu5uevtyA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Dec 05, 2020 at 03:10:15PM -0800, Linus Torvalds wrote:
> On Sat, Dec 5, 2020 at 2:34 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > Am I the only one who thinks this would be a good idea?
> 
>         err = third_step(obj, 0);
> 
>    err_undo_2s:
>         second_undo(obj);
>    err_undo_1s:
>         first_undo(obj);
>         return err;
> 
> iow, the "undo" parts are often done even for the success cases. This
> is particularly true when those first steps are locking-related, and
> the code always wants to unlock.
> 
> Sparse also doesn't really do any value analysis, so I suspect it
> wouldn't be trivial to implement in sparse anyway.

Yes but ... (see here under).
 
> Having some kind of smarter compile-time assert could be useful in
> general, but as mentioned, sparse doesn't really do value range
> propagation right now, so..
> 
> Luc, any reactions?

I agree but the code Jakub showed is very constrained:
   * only 2 return points
   * one of them being 0, the other is to be checked.
and I think this should be checkable easily, something like:
   * identify the highest point that can't reach the 'return 0'
   * check that the only way to reach this point is via a zero/non-zero
     test of the 'err' variable/returned value (which is a very
     limited kind of value analysis after all).
But sure, these are rather strict constraints but maybe it's
common for net drivers?

Otherwise, yes, it's probably better to annotate the function itself
or the point of interest (via some kind of assertion) than the
variable.

I've not much idea how much this would be useful, though.

-- Luc
