From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [GIT PULL linux-next] Add Compiler Attributes (v6) tree
Date: Fri, 5 Oct 2018 13:32:25 +0200
Message-ID: <CANiq72kuTr09CjE0jcNFkdO-gOFCjYp+REuLPq5V9c4Y8KvWXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Steven Rostedt <rostedt@goodmis.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Olof Johansson <olof@lxom.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, "David S . Miller" <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Sandipan Das <sandipan@linux.vnet.ibm.com>, Andrey Konovalov <andreyknvl@google.com>, David Woodhouse <dwmw2@infradead.org>, Will Deacon <will.deacon@arm.com>, Philippe Ombredanne <pombredanne@nexb.com>Paul
List-Id: linux-sparse@vger.kernel.org

Hi Stephen,

As discussed, here it is the Compiler Attributes series for
linux-next. This time the original v6, based on -rc6.

The changes w.r.t. v5:

  - Added latest Reviewed-by's and Tested-by's.

The conflicts are trivial to solve, but if you want a reference, take
a look at (rebased on top of next-20181005):

  https://github.com/ojeda/linux.git compiler-attributes-rebased

Thanks!

Cheers,
Miguel

The following changes since commit 17b57b1883c1285f3d0dc2266e8f79286a7bef38:

  Linux 4.19-rc6 (2018-09-30 07:15:35 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git compiler-attributes

for you to fetch changes up to f0604f63033d4020f019d2aaee805c1075b1077b:

  Compiler Attributes: ext4: remove local __nonstring definition
(2018-09-30 20:14:04 +0200)

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
 include/linux/compiler_attributes.h            | 258 +++++++++++++++++++++++++
 include/linux/compiler_types.h                 | 101 ++--------
 scripts/Makefile.extrawarn                     |   1 +
 12 files changed, 341 insertions(+), 189 deletions(-)
 create mode 100644 Documentation/process/programming-language.rst
 create mode 100644 include/linux/compiler_attributes.h
