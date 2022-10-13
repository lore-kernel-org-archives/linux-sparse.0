Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F318C4332F
	for <linux-sparse@archiver.kernel.org>; Thu, 13 Oct 2022 19:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJMThW (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 13 Oct 2022 15:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJMThW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 13 Oct 2022 15:37:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DDC16698E
        for <linux-sparse@vger.kernel.org>; Thu, 13 Oct 2022 12:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665689840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jVovCSzH+8utlFay2NdxOUG1pH0EjSKl/qJoAZkz6d8=;
        b=PZgMfrFng3lQj06Tg70g8Pju9JpCPoTJxYa5GaJwxRFKh+yLmP7+J4yDYOo0j31E+z14wx
        7HdoVdVj77CLqtd/KtucNgKFQNeWDp/M5YAuLqiDhElYsbLxA/lLlppW57n6+vW1JibVOF
        PUsTtEIxOTN6DmvAWWlmx0ixR81Wu1g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-244-EX6Lnt_rONCNt8Zi4O_3Yw-1; Thu, 13 Oct 2022 15:37:19 -0400
X-MC-Unique: EX6Lnt_rONCNt8Zi4O_3Yw-1
Received: by mail-qk1-f197.google.com with SMTP id u6-20020a05620a430600b006e47fa02576so1625986qko.22
        for <linux-sparse@vger.kernel.org>; Thu, 13 Oct 2022 12:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVovCSzH+8utlFay2NdxOUG1pH0EjSKl/qJoAZkz6d8=;
        b=gDWltRkTzdVV4+Nc7o+W+ShaHZcYWqdy4TDJWCjztG9heszEuNg+8WoMCpEKMGoI3D
         zGo2WQ63AzG1WdULwPyIks4QzDK5R7UhyAoA1Z0E3BEF1Z3WgaSNGRotfMs1pEEPl4yj
         3e6Yb2GB643N22gLshKC98e/R3Z4XlBNzkHhPjiB31t4AH/fHnEm46hDUdw6M9H/cZyb
         HXmv/W+dsnWg8mSYdF4p5A6XbxrjBJ8UzJN6McT2/qj4SYS1qRIm0ooU+1pQFjwfaG15
         a89i/D7CVDm9SZP0hliZJhXEw4F2vjDqYisC9x6R89YQiL9MnNP2dhK8XTSW10/M5UvW
         dfSg==
X-Gm-Message-State: ACrzQf2qS03kC+/jrFbXNESzzHCsjDSaIzT7/IrBeqcXn0ezmlqQn6om
        Yb+StN7+pBFfYDtDeY7t6sJcNS0U2qtWSJ1kDB8kWDt8M/1KpUsJgwjEShrnZgrMDPwC4Ac5Nzh
        k92xkjTHO/fpsXy3ehO1vT9QGK2G3d3Tb6F8PRJgfniC1+v88dk5X7RQOhNe0B3sIkKflWIoX2Q
        IC
X-Received: by 2002:a05:620a:25d4:b0:6bb:f596:97d0 with SMTP id y20-20020a05620a25d400b006bbf59697d0mr1219925qko.411.1665689838593;
        Thu, 13 Oct 2022 12:37:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6jT7X/pAKPYmyq2AJLKB1fDw7rmMhDXAhwYk6OKFW2I0QGn7qealSkzWwxBXG0wwg1CEeHgw==
X-Received: by 2002:a05:620a:25d4:b0:6bb:f596:97d0 with SMTP id y20-20020a05620a25d400b006bbf59697d0mr1219898qko.411.1665689838307;
        Thu, 13 Oct 2022 12:37:18 -0700 (PDT)
Received: from t14s.localdomain (c-73-69-212-193.hsd1.ma.comcast.net. [73.69.212.193])
        by smtp.gmail.com with ESMTPSA id ay39-20020a05620a17a700b006ed30a8fb21sm490071qkb.76.2022.10.13.12.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 12:37:17 -0700 (PDT)
Message-ID: <e583356b104fbef6940a06bf360aa59c42bba3c2.camel@redhat.com>
Subject: address_space and noderef on non-pointer types
From:   David Malcolm <dmalcolm@redhat.com>
To:     linux-sparse@vger.kernel.org, linux-toolchains@vger.kernel.org
Cc:     David Faust <david.faust@oracle.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Date:   Thu, 13 Oct 2022 15:37:16 -0400
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Is it valid to apply the sparse attributes 'noderef' or 'address_space'
to non-pointers, and if so, what does this mean?

I see examples of using them on non-pointers in sparse's own test
suite.

For example, in:
https://git.kernel.org/pub/scm/devel/sparse/sparse.git/tree/validation/type=
-attribute-as.c
"struct s" is annotated with
  __attribute__((address_space(__as)))

Similarly, there's
https://git.kernel.org/pub/scm/devel/sparse/sparse.git/tree/validation/node=
ref.c#n18
where sparse accepts:
  struct x __A x;
e.g.:
  struct x __attribute__((noderef)) x;

The docs for noderef:=20
https://git.kernel.org/pub/scm/devel/sparse/sparse.git/tree/Documentation/a=
nnotations.rst#n54
say:
"This attribute is to be used on a r-value to specify it cannot be
dereferenced. A pointer so annotated is in all other aspects exactly
like a pointer  but trying to actually access anything through it will
cause a warning."
What is the intended meaning of "noderef" for a non-pointer?

Similarly, the docs for "address_space" say:
"This attribute is to be used on pointers to specify that its target is
in address space *name* (an identifier or a constant integer)."

but don't specify what it means to use in on a non-pointer.

Sorry if this is a silly question.

The background here is that I'm a GCC developer and have been
experimenting with implementing some sparse attributes and warnings
"natively" in GCC; see e.g. the RFE in GCC bugzilla for implementing
address_space, noderef and force here:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D59850 ; I'm trying to get
my patched GCC to handle Sparse's own test suite and hence running into
this issue.

Thanks
Dave

