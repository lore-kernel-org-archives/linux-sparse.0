Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864193DB300
	for <linux-sparse@vger.kernel.org>; Wed, 17 Jun 2026 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707030; cv=none; b=uGlufSesVOBIMoZQsRKk/0m9oCfPQUIbGtn91qiaepIU5q/95f+aXqsaw4C9tOWRC9cZ8AhrrwDqYzFQkKE/J3sdRiopztrU7qalti1lte3m6c2ay8k17sbVYSpMAiQhRyu/MRR6XC6gv1NaUmROA3CAM852QELi4KlYW4pNvFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707030; c=relaxed/simple;
	bh=paO1vgUthU5S1UguLtJhMiEba0VGkFisJn6pchu9PtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNra5CanxQsqgcliElv6jgx5RR9WrvIsKmCw7npLALty8PR9GYjplHme0x59QVxsglPTzcyghem2oxa5dUADiLklvc2/L/4/UD95MOBMIgoPLspFarajZoFeoV9UWTyetm9sxQFeWT7CUFXv8fphU7204B3WTJ9sPW6sqCo0LEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O80xP+7J; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O80xP+7J"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490ac357c55so55078075e9.1
        for <linux-sparse@vger.kernel.org>; Wed, 17 Jun 2026 07:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781707028; x=1782311828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SnggsuHRRUTHM4ADQSpxFqSU4Mm2zmvuXwye0qStgAY=;
        b=O80xP+7JSgOTWeOePU7g4YlLMNonEOhlIQsi7TXelz/fq5BSk1PDA5ejqmSsi6q01y
         TU+3UzHJ7G4Ls/PnColzyhkLANqh6BXwHwg2o/ohKl8ZpN12tSD/14a37WY4LR5TgG5P
         682zwiT3CIyLI5X5KLoU/WBo+oNQwm647uGGXeE04UMj+32nAi78yOwNKLwqtiz9BleH
         zYioN8Gv2ZUKnbvl3aeIte1njC3fYMtz8QB9eCdX1YwsNG8bEXuBWwSQK8ySFJsbdn/A
         99rzSspyT/VKYB2zE6/qjiSg3flVHH8eL56q+i0A/lj8lLr1zhYekrCCml1KnyIF6DS0
         w4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781707028; x=1782311828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnggsuHRRUTHM4ADQSpxFqSU4Mm2zmvuXwye0qStgAY=;
        b=VasV/YKl30hin/sIHEu/mJoll//QaICbocErQLjti5d/C8+pQR/M6/Se4jkMeHW8md
         07yVCrJ68nYFfSGz7E68iZKboyDyKvVSG0nQEj0VjSZJKpn6072c2nlphHrii94mwyqi
         zpGiV4TOaNTQtY/bIK8iq9RGtH32vzeOnqm7G+DyP6fy2ccxVw1hH0KXjMySdM0qHvE0
         QuaOxBdoX+B9dSvFVaKV8s0UnZfCFoIFTx/Q4HjPALreWLdXlXwaXQd5MnVDrOfr4Beh
         DLNEZR3ja8XYJ72Hs6szCKxWILoF7ZK/JBCNjV3zOPWsIYl+8YZlZFPbBX41Qb8o+gEZ
         k6nA==
X-Gm-Message-State: AOJu0YwJ38Q4yLRqdvIZvCh+YrU8tYKIquWdCZyyeKUeVsbUv6cwguwn
	GZ6ODHmckj5i51Vx9mGEMAMdZLfYazE3pJEB11vhYAq2K7QIhVL2kOXW
X-Gm-Gg: Acq92OH/eYpSAA/Wt7O/9VRxL33EUhRV62UxaXJ3d0KyszqwII/HfD/Y7XL+rVrCnsf
	g2lmaKlZgaFIDluY1Oc3eFrsZOx6FxcXTSd6yXD+A4vEGJHrqvfU7JqOMU2Z3wZxuNJxeKoseB0
	qPmlwd7jnViz2xQnSPv/DB7Zspv4PVu9wY9SiRRKXShgm69134ay5Z8TEQt8EW8W607VUyZ8Skb
	oPGgU8z58SX7Twq7BZDx8PiCfpZlwn5h7ojAtOtdQpopqIhz1Nj5Rsg1UbM8Ks6tgysxKGe8PXp
	QAdgDVXhAJzeIWGOrKlKKAHgIIUGWlLWbdsviHkZm3lz+EKIFRf/oK0zRyrh6RlT3RlJZsQKFdM
	yAytQZnY+VPI6jpdTN/5wK0l8r+Ol6rpyAbasIpdogOc8wgLNENijEwUgsrosQa/gReHlYczKh+
	ltdBD69Fdp
X-Received: by 2002:a05:600c:a148:b0:492:329c:3d39 with SMTP id 5b1f17b1804b1-492333ca336mr50540575e9.20.1781707027601;
        Wed, 17 Jun 2026 07:37:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2e6a8fsm55554391f8f.37.2026.06.17.07.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 07:37:06 -0700 (PDT)
Date: Wed, 17 Jun 2026 17:37:02 +0300
From: Dan Carpenter <error27@gmail.com>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-sparse@vger.kernel.org
Subject: Re: segfault with latest arm64 linux kernel build
Message-ID: <ajKxDqLtrI2kiypt@stanley.mountain>
References: <ebcf4663-4c95-4b51-887c-d0c99b8b80ea@codethink.co.uk>
 <0e0a2543-bac9-41d3-9c06-1579395a1de4@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e0a2543-bac9-41d3-9c06-1579395a1de4@codethink.co.uk>

There is a NULL dereference parsing a goto.

The got is in the msm_gem_lock_vm_and_obj() function when it calls
the drm_exec_retry_on_contention(exec) macro.

The pre-processed code looks something like this:

__UNIQUE_ID_drm_exec_1299:
	for (void *const __attribute__((__unused__)) __drm_exec_retry_ptr = &&__UNIQUE_ID_drm_exec_1299;
		drm_exec_cleanup(exec);) {
...
		if (drm_exec_is_contended(exec))
			goto *__drm_exec_retry_ptr;

Adding a NULL check fixes the crash but that might not be the
right way to actually fix it.

---
 simplify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 68c5f9c74021..897fc827dc98 100644
--- a/simplify.c
+++ b/simplify.c
@@ -2734,7 +2734,7 @@ static int simplify_cgoto(struct instruction *insn)
 		break;
 	case OP_LABEL:
 		target = def->bb_true;
-		if (!target->ep)
+		if (!target || !target->ep)
 			return 0;
 		FOR_EACH_PTR(insn->multijmp_list, jmp) {
 			if (jmp->target == target)
-- 
2.53.0

