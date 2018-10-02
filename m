From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [GIT PULL linux-next] Add Compiler Attributes tree
Date: Tue, 2 Oct 2018 15:47:12 +0200
Message-ID: <CANiq72=rgT9cPWH64Tf_8gAU09EiH5FvGqFUdOjV=spVbM5m8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Steven Rostedt <rostedt@goodmis.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Olof Johansson <olof@lxom.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, "David S . Miller" <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Sandipan Das <sandipan@linux.vnet.ibm.com>, Andrey Konovalov <andreyknvl@google.com>, David Woodhouse <dwmw2@infradead.org>, Will Deacon <will.deacon@arm.com>, Philippe Ombredanne <pombredanne@nexb.com>Paul
List-Id: linux-sparse@vger.kernel.org

Hi Stephen,

The Compiler Attributes series has been stable for 10+ days. To
increase testing before 4.20, I would to request it being picked up
for -next.

The changes w.r.t. v5 in the LKML:

  - Rebased on top of next-20180928, which required removing
aligned_largest, which was removed by 9503cd9cbaba
("include/linux/compiler*.h: add version detection to
asm_volatile_goto").
  - Added latest Reviewed-by's and Tested-by's.

Thanks!

Cheers,
Miguel

The following changes since commit 4794a36bf08dfa89fe636e5080db9d8350e255dd:

  Add linux-next specific files for 20180928 (2018-09-28 15:26:51 +1000)

are available in the Git repository at:

  https://github.com/ojeda/linux.git compiler-attributes

for you to fetch changes up to dbce062c0b519db1cdad8d87ab46851f0be6bdea:

  Compiler Attributes: ext4: remove local __nonstring definition
(2018-10-02 15:11:26 +0200)

----------------------------------------------------------------
Miguel Ojeda (15):
      Compiler Attributes: remove unused attributes
      Compiler Attributes: always use the extra-underscores syntax
      Compiler Attributes: remove unneeded tests
      Compiler Attributes: homogenize __must_be_array
      Compiler Attributes: remove unneeded sparse (__CHECKER__) tests
      Compiler Attributes: add missing SPDX ID in compiler_types.h
      Compiler Attributes: use feature checks instead of version checks
      Compiler Attributes: KENTRY used twice the "used" attribute
      Compiler Attributes: remove uses of __attribute__ from compiler.h
      Compiler Attributes: add Doc/process/programming-language.rst
      Compiler Attributes: add MAINTAINERS entry
      Compiler Attributes: add support for __nonstring (gcc >= 8)
      Compiler Attributes: enable -Wstringop-truncation on W=1 (gcc >= 8)
      Compiler Attributes: auxdisplay: panel: use __nonstring
      Compiler Attributes: ext4: remove local __nonstring definition

 Documentation/process/index.rst                |   1 +
 Documentation/process/programming-language.rst |  45 +++++
 MAINTAINERS                                    |   5 +
 drivers/auxdisplay/panel.c                     |   7 +-
 fs/ext4/ext4.h                                 |   9 -
 include/linux/compiler-clang.h                 |   5 -
 include/linux/compiler-gcc.h                   |  70 +------
 include/linux/compiler-intel.h                 |   9 -
 include/linux/compiler.h                       |  19 +-
 include/linux/compiler_attributes.h            | 257 +++++++++++++++++++++++++
 include/linux/compiler_types.h                 | 100 ++--------
 scripts/Makefile.extrawarn                     |   1 +
 12 files changed, 340 insertions(+), 188 deletions(-)
 create mode 100644 Documentation/process/programming-language.rst
 create mode 100644 include/linux/compiler_attributes.h
