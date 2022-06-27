Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA3DCCA480
	for <linux-sparse@archiver.kernel.org>; Mon, 27 Jun 2022 15:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbiF0PPc (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 27 Jun 2022 11:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbiF0PPb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Jun 2022 11:15:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2E17186C4
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 08:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656342929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=GO/MBM6YkTfuoJcYEX6KXF0OAWbbLiKRXPHLGR2ttc0=;
        b=Y+RJbqtW5hTiuIXkKqwaAYSWMQZsq5g3c9fWjiLYSr9Y8iw0HlzC9DCIgFt7EKl+FzB8q2
        1zFusfpSZP21iNi4qs6C2pBNfGLKb6BC95FvU1Czb+jHiMr9FIoayx/v2ufRWS7taue2U1
        /+CIMoaQQ4YDmG2/4/PxK8KeOrCuDQg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-76myjDMpOsWzxXZPVuXpPw-1; Mon, 27 Jun 2022 11:15:28 -0400
X-MC-Unique: 76myjDMpOsWzxXZPVuXpPw-1
Received: by mail-qv1-f72.google.com with SMTP id j6-20020a05621419c600b004704e6665caso9561069qvc.6
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 08:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GO/MBM6YkTfuoJcYEX6KXF0OAWbbLiKRXPHLGR2ttc0=;
        b=F3j2M7uqy3vrWP/Ip0VelICP0wbwx4KGk52+6gg3E2LmETWzIb9t4ZHTC0pTCG5Z12
         vuVHF+H2QSKUq+K83a4daVmYpfLc8gHoDf9YN6D8Zd0YJEmDlWvCSR6eCkQJkyDuW6Ie
         5AAqS6Y3Robpq/MkVxWEuyzOFQjL2XcUsJygmjdrfqj6D4jowvGvGLwdWelk0W0Bv+q/
         30P1U7h6fCB5bekRn2wuxTNiir5qlFligxyrI0Pnbm1L87ZY+oTRIupKT+R5cwHcSJ8i
         xyGd+XS7/Qo5cCxDQG59W60w8rcbSBzOzYMS/NGhDPQoK0O1bAktcXbsSGapwvOOIuWI
         /pNQ==
X-Gm-Message-State: AJIora9LsjVNkOhMsEPcix7M0cYnst+NJm3kAlWGOxs3dG4SHR/1lvdM
        cHZZndto1JyvTXVlQ61PVQkd2rjY2p+gCSAKa5q16bx2jBv/yoHOK5PZRjuV37XF7yFPa3g9qLR
        n2IHf8JAjPGGZ+XYhOdzrDAxLw0GR+bAGVbNVcM8c
X-Received: by 2002:a05:622a:1306:b0:31a:f73e:3d6d with SMTP id v6-20020a05622a130600b0031af73e3d6dmr2571838qtk.339.1656342927991;
        Mon, 27 Jun 2022 08:15:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sLAh5El7fzCaEzHLFipY66Dss3D0usdEJV1zsOaHo/Tcrhw9/BnSJl91k2QpDJulafVoKAuEerqqufAfMLAYY=
X-Received: by 2002:a05:622a:1306:b0:31a:f73e:3d6d with SMTP id
 v6-20020a05622a130600b0031af73e3d6dmr2571817qtk.339.1656342927725; Mon, 27
 Jun 2022 08:15:27 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 27 Jun 2022 11:15:17 -0400
Message-ID: <CAK-6q+hd-L54cqOiFNuufS2_VF5XS0R8cjQL7es8921+2u3uwQ@mail.gmail.com>
Subject: sparse warnings related to kref_put_lock() and refcount_dec_and_lock()
To:     linux-sparse@vger.kernel.org
Cc:     cluster-devel <cluster-devel@redhat.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=aahringo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi,

I recently converted to use kref_put_lock() in fs/dlm subsystem and
now I get the following warning in sparse:

warning: context imbalance in 'put_rsb' - unexpected unlock

It seems sparse is not able to detect that there is a conditional
requirement that the lock passed to kref_put_lock() (or also
refcount_dec_and_lock()) is locked or not. I evaluate the return value
to check if kref_put_lock() helds the lock and unlock it then. The
idea is that the lock needs only to be held when the refcount is going
to be zero.

It seems other users unlock the lock at the release callback of
kref_put_lock() and annotate the callback with "__releases()" which
seems to work to avoid the sparse warning. However this works if you
don't have additional stack pointers which you need to pass to the
release callback.

My question would be is this a known problem and a recommended way to
avoid this sparse warning (maybe just for now)?

Thanks.

- Alex

