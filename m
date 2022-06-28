Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA0FC43334
	for <linux-sparse@archiver.kernel.org>; Tue, 28 Jun 2022 08:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343491AbiF1I6b (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 28 Jun 2022 04:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344086AbiF1I60 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Jun 2022 04:58:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E06BBAC;
        Tue, 28 Jun 2022 01:58:25 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sb34so24260918ejc.11;
        Tue, 28 Jun 2022 01:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=weYByFyTnVPfMPS/NnD/urU6LcJtRq/Ol19ih/S3E4o=;
        b=HJ87P6wzw8qmmONZYOYnEJ9awoi57XmNcRc1v5XQq+5LjnZ8YS53vWQR6UMwqd7zeM
         bPE2R96FCVHsWMB98YdrEGMKHaaoCFUgmy+FyOy8zC55LTAPPMBiy+yr9Uu0m97DGLbq
         zS9LLl5xRghoOzTlFiuR9wUFA92PvEiv17tLguC+m04IVHDjKpzhPFUXBlvIfekeeHey
         5EuSNSgxgmGe9fcAo5iWPGmJUqUSVguWNnZactCEGJz4D8iJySvUKMAuFI54ba+XAR85
         YQHOyKCNpprecFX6cF8wUaIvjJ8u0Ct9wY3eDgtlSBpq7NDjUUkZQx3sbI5exh7+FGQ0
         vzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=weYByFyTnVPfMPS/NnD/urU6LcJtRq/Ol19ih/S3E4o=;
        b=vZEltxsGoYTSd8s59NnqGbbgxtqS+H4PswMJR7TZgDkFhgIg92MV2Pjc5GjJTC1v4e
         s0wD631xOYJDSbwyfek+Ug6xsR/HeffsCmpdD94dfqEg9MOMo6paDxZPbn3yZDOSGEif
         L8LP814xMW+4yTFnWlJLe8jNxj5QpG+1tfiyR4ylIZKfomt04c+breUaG9QDTxW7ai6q
         MD3pqYkoazz4EjiyBccS3jg/rl1+zd0glqRlX2Z4/LxYHT6WpzCXysEv7xATuiu2nuQN
         M5iB+P0Joo6YAMl1XdOROx4+zMeymn/DtjxEQUFoar5rHOpg650d1pGP018tcUMQRDEM
         CDwQ==
X-Gm-Message-State: AJIora/Na4X1XocvdTCzsnBjqbm+sdt3LqF7punty9f95MqNISK6B3I5
        mbW3+AmqOwFvR19zikic08g6p3hq/js=
X-Google-Smtp-Source: AGRyM1vl6DbgnRcb8+XhzVRp1PSCK/CNEG9/yjT7NwV8iD9OSQLF9FY8tvWF6wcizf33P5lwOQf8GQ==
X-Received: by 2002:a17:907:7206:b0:726:abaf:16f5 with SMTP id dr6-20020a170907720600b00726abaf16f5mr7485542ejc.70.1656406703899;
        Tue, 28 Jun 2022 01:58:23 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id p17-20020a056402501100b0043787ad7cfasm4405386eda.22.2022.06.28.01.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 01:58:23 -0700 (PDT)
Date:   Tue, 28 Jun 2022 10:58:21 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     jacob.e.keller@intel.com, akpm@linux-foundation.org,
        thunder.leizhen@huawei.com, linux-sparse@vger.kernel.org,
        cluster-devel <cluster-devel@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: sparse warnings related to kref_put_lock() and
 refcount_dec_and_lock()
Message-ID: <20220628085821.kn3jjrviyprgai4w@mail>
References: <CAK-6q+hd-L54cqOiFNuufS2_VF5XS0R8cjQL7es8921+2u3uwQ@mail.gmail.com>
 <20220627184232.tjfuzeir57l3h5ll@mail>
 <CAK-6q+haOfQD8_N6pEm80BTrUXwaj07ZBcXP-EBHftpTVEc1XQ@mail.gmail.com>
 <CAK-6q+g795MwPvUGxWXTE+s-TfJnbh2wf=Udb1k7r6ru-4FTMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK-6q+g795MwPvUGxWXTE+s-TfJnbh2wf=Udb1k7r6ru-4FTMQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Jun 27, 2022 at 09:06:43PM -0400, Alexander Aring wrote:
> >
> > If we change the refcount code to _never_ calling unlock() for the
> > specific lock, then all those foo_and_lock_bar() functions can be
> > annotated with "__acquires()". This should also end in the same code?
> 
> sorry, this will not work because of the first condition of "if
> (refcount_dec_not_one(r))" which will never hold the lock if true...
> that's what the optimization is all about. However, maybe somebody has
> another idea...

I would certainly not recommend this but ...
if it's OK to cheat and lie then you can do:
+	bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock) __acquires(lock);
+
	bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
	{
-		if (refcount_dec_not_one(r))
-			return false;
+		if (refcount_dec_not_one(r)) {
+			__acquire(lock);
+			return false;
+		}
	
		spin_lock(lock);
		if (!refcount_dec_and_test(r)) {
			spin_unlock(lock);
+			__acquire(lock);
			return false;
		}
	
		return true;
	}

In other word, pretend that the lock is always taken but ...
1) it's ugly
2) it's lying and can be confusing
3) now all the users of this function will have an imbalance problem
   (but they probably already have one since refcount_dec_and_lock()
    is not annotated).

What is needed is some kind of annotation for conditional locks.
I've tried a few time and in itself it was working but in most
cases the usage pattern was so that there was a imbalance anyway.

-- Luc
