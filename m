From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] tell gcc optimizer to never introduce new data races
Date: Mon, 16 Jun 2014 13:29:27 +0300
Message-ID: <20140616102927.GA2994@mwanda>
References: <alpine.LNX.2.00.1406101517300.9378@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <gcc-return-183751-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1406101517300.9378@pobox.suse.cz>
To: Jiri Kosina <jkosina@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Martin Jambor <mjambor@suse.cz>, Petr Mladek <pmladek@suse.cz>, linux-kernel@vger.kernel.org, gcc@gcc.gnu.org, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

Adding "--param allow-store-data-races=0" to the GCC options for the
kernel breaks C=1 because Sparse isn't expecting a GCC option with that
format.

It thinks allow-store-data-races=0 is the name of the file we are trying
to test.  Try use Sparse on linux-next to see the problem.

$ make C=2 mm/slab_common.o
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHECK   scripts/mod/empty.c
No such file: allow-store-data-races=0
make[2]: *** [scripts/mod/empty.o] Error 1
make[1]: *** [scripts/mod] Error 2
make: *** [scripts] Error 2
$

regards,
dan carpenter
