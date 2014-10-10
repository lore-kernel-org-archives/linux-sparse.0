From: "Franco, Scott" <Scott.Franco@caviumnetworks.com>
Subject: Sparse context warning on 0.5.0
Date: Fri, 10 Oct 2014 17:04:49 +0000
Message-ID: <4801d85f4f4c4f97ba83a075fc9a80b4@BY1PR0701MB1240.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-by2on0059.outbound.protection.outlook.com ([207.46.100.59]:52160
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751796AbaJJRT2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 10 Oct 2014 13:19:28 -0400
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>

Hi,

I am using sparse 0.5.0 release. I am getting several context check errors on my code.
I reduced a routine that was being flagged to the minimum, and I still get the error:

/nfs/causers2/sfranco/projects/cnnic70xx_rearch/host/driver/src/linux/cavium/octeon_poll.c:130:5: warning: context imbalance in 'octeon_register_poll_fn' - wrong count at exit

The routine now is:

static spinlock_t mylock = SPIN_LOCK_UNLOCKED;

int octeon_register_poll_fn(int oct_id, octeon_poll_ops_t * ops)

{

    spin_lock(&mylock);
    spin_unlock(&mylock);

    return 0;
}

Ie., stripped to the bare minimum. My understanding from reading the docs and mails on the
subject is that a function that does not enter with the lock, acquires and releases it inside the
function and exits with the lock unlocked, does not need annotation with __acquires or __releases.

Any hints you can give me?

Machine: x64, Scientific Linux (RHEL).

Thanks,

Scott Franco
Cavium Networks

