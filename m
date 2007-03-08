From: Pavel Roskin <proski-mXXj517/zsQ@public.gmane.org>
Subject: Re: sparse using insane amounts of memory
Date: Thu, 08 Mar 2007 11:33:28 -0500
Message-ID: <1173371608.21465.12.camel@dv>
References: <1173319356.3546.54.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1173319356.3546.54.camel-YfaajirXv214zXjbi5bjpg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sparse-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-sparse@vger.kernel.org

On Thu, 2007-03-08 at 03:02 +0100, Johannes Berg wrote:
> Hi,
> 
> I was running make C=2 over the current wireless-dev tree (as of commit
> 4533da881f2d8c3e0dbb5b3dbc7a919e12438a8a) and reached
> drivers/net/wireless/mac80211/rt2x00/rt2400pci.c when sparse started
> using more and more memory. It went up to about 1 GB. Now I don't know
> whether to blame sparse or if something's wrong with that file but it
> does seem to be a bit excessive... Similar with all the other driver
> files in that directory, yet I've not seen such a case before.

You forgot the version of sparse.  I cannot reproduce the problem with
the current sparse from git
(git://git.kernel.org/pub/scm/linux/kernel/git/josh/sparse.git)

There were some bad bugs fixed recently.  If you are using the snapshot,
please download the latest snapshot now, as they were out-of-date until
very recently.

If you still have the problem, please remove rt2400pci.o and run:

make CC="gcc -save-temps -D__CHECKER__" KBUILD_NOCMDDEP=1

rt2400pci.i will be found in the root of the build tree.  Please see if
you have a problem with it.  If you do, please put it online and post
the URL.

If git sparse resolves the problem, I urge sparse developers to make
another release soon.

-- 
Regards,
Pavel Roskin
