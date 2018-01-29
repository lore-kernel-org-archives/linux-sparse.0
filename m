From: aaptel@suse.com (=?utf-8?Q?Aur=C3=A9lien?= Aptel)
Subject: wrong "imbalanced unlock" warning?
Date: Mon, 29 Jan 2018 17:32:53 +0100
Message-ID: <87k1w0d3re.fsf@suse.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:53526 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeA2Qc4 (ORCPT
        <rfc822;groupwise-linux-sparse@vger.kernel.org:0:0>);
        Mon, 29 Jan 2018 11:32:56 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hi,

While compiling the kernel cifs for-next (from here [1]) I've run into a
strange sparse warning.

fs/cifs/smbdirect.c:1943:56: warning: context imbalance in 'smbd_recv_buf' - unexpected unlock

The code is basically doing:

	int queue_length;
	....
	queue_length = info->reassembly_queue_length;
	....
	/*
	 * No need to lock if we are not at the
	 * end of the queue
	 */
	if (!queue_length)
	    spin_lock_irq(&info->reassembly_queue_lock);
	list_del(&response->list);
	queue_removed++;
	if (!queue_length)
	    spin_unlock_irq(&info->reassembly_queue_lock);


I don't think there's anything wrong with this code. I've tried adding a
test in sparse validation/context.c to reproduce the warning:

add this at the bottom:

    static void warn_cifs(void)
    {

        int x;
        x = condition;

        if(!x)
            a();

        if(!x)
            r();
    }

a() adds a lock, r() removes it.

and in validation/ run

    ./test-suite single context.c
         TEST    Check -Wcontext (context.c)
    context.c passed !

I've played around with the test and tried to make it similar to
smbdirect.c code (see attached file). Place it in validation and run
./test-suite single cifs.c

I've also checked out my system revision of sparse, but I couldn't make
it fail either.

Although it doesn't look like it, maybe there is an issue in
smbdirect.c, what do you think?

1: git://git.samba.org/sfrench/cifs-2.6.git tip is 36c7ce4a17f2 as of
   now

   make sure to enable INFINIBAND, CIFS and CIFS_SMB_DIRECT


--=-=-=
Content-Type: text/x-csrc
Content-Disposition: attachment; filename=cifs.c
Content-Description: cifs.c


static void lock(void) __attribute__((context(0,1)))
{
	__context__(1);
}

static void unlock(void) __attribute__((context(1,0)))
{
	__context__(-1);
}

extern int cond, cond2;

static void foo (void)
{
}

static void warn_cifs(void)
{

again:
	if (cond) {
		return;
	}

	if (cond) {
		int x;

		x = cond2;

		while (cond) {
			if (cond) {
				goto read_rfc1002_done;
			}

			if (cond) {
				x--;
				if (!x)
					lock();
				foo();
				if (!x)
					unlock();

			} else
				foo();

		}

		lock();
		foo();
		unlock();

read_rfc1002_done:
		return;
	}


	if (cond)
		return;

	goto again;
}

/*
 * check-name: Check -Wcontext bis
 *
 * check-error-start
 * check-error-end
 */

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Linux GmbH, Maxfeldstra=C3=9Fe 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N=
=C3=BCrnberg)

--=-=-=--
