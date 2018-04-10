From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3] sparse: add -Wpointer-arith flag to toggle
 sizeof(void) warnings
Date: Tue, 10 Apr 2018 21:41:19 +0200
Message-ID: <20180410194117.ei4eo3kaxvv2ezdx@ltop.local>
References: <20180410010204.qeudkkru4jilun3v@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180410010204.qeudkkru4jilun3v@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: linux-sparse@vger.kernel.org, Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, Martin Uecker <Martin.Uecker@med.uni-goettingen.de>, Al Viro <viro@ZenIV.linux.org.uk>, Christopher Li <sparse@chrisli.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Mon, Apr 09, 2018 at 03:02:04PM -1000, Joey Pabalinas wrote:
> Recent changes to the min()/max() macros in include/linux/kernel.h
> have added a lot of noise when compiling the kernel with Sparse checking
> enabled. This mostly is due to the *huge* increase in the number of
> sizeof(void) warnings, a larger number of which can safely be ignored.
> 

Thank you very much.

There is just a problem with the test but it's my fault as I
pointed to you to my tree but the master tree lack a lot of fixes
and have problems when dereferencing function pointers.
So, for the master tree, I propose to use a version with these
tests removed:
	git://github.com/lucvoo/sparse-dev.git pointer-arith-v3

Cheers,
-- Luc
