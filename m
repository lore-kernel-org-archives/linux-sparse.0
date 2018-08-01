From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
Date: Wed, 1 Aug 2018 18:52:09 +0200
Message-ID: <CACT4Y+aZtph5qDsLzTDEgpQRz4_Vtg1DD-cB18qooi6D0bexDg@mail.gmail.com>
References: <cover.1530018818.git.andreyknvl@google.com>
 <20180628105057.GA26019@e103592.cambridge.arm.com>
 <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
 <20180629110709.GA17859@arm.com>
 <CAAeHK+wHd8B2nhat-Z2Y2=s4NVobPG7vjr2CynjFhqPTwQRepQ@mail.gmail.com>
 <20180703173608.GF27243@arm.com>
 <CAAeHK+wTcH+2hgm_BTkLLdn1GkjBtkhQ=vPWZCncJ6KenqgKpg@mail.gmail.com>
 <CAAeHK+xc1E64tXEEHoXqOuUNZ7E_kVyho3_mNZTCc+LTGHYFdA@mail.gmail.com>
 <20180801163538.GA10800@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180801163538.GA10800@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Kate Stewart <kstewart@linuxfoundation.org>, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Paul Lawrence <paullawrence@google.com>, Linux Memory Management List <linux-mm@kvack.org>, Alexander Potapenko <glider@google.com>, Chintan Pandya <cpandya@codeaurora.org>, Christoph Lameter <cl@linux.com>, Ingo Molnar <mingo@kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>, Jann Horn <jannh@google.com>, Mark Brand <markbrand@google.com>, kasan-dev <kasan-dev@googlegroups.com>, linux-sparse@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>, Arnd Bergmann <arnd@arndb.de>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Andrey Konovalov <andreyknvl@g>
List-Id: linux-sparse@vger.kernel.org

On Wed, Aug 1, 2018 at 6:35 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Andrey,
>
> On Tue, Jul 31, 2018 at 03:22:13PM +0200, Andrey Konovalov wrote:
>> On Wed, Jul 18, 2018 at 7:16 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
>> > On Tue, Jul 3, 2018 at 7:36 PM, Will Deacon <will.deacon@arm.com> wrote:
>> >> Hmm, but elsewhere in this thread, Evgenii is motivating the need for this
>> >> patch set precisely because the lower overhead means it's suitable for
>> >> "near-production" use. So I don't think writing this off as a debugging
>> >> feature is the right approach, and we instead need to put effort into
>> >> analysing the impact of address tags on the kernel as a whole. Playing
>> >> whack-a-mole with subtle tag issues sounds like the worst possible outcome
>> >> for the long-term.
>> >
>> > I don't see a way to find cases where pointer tags would matter
>> > statically, so I've implemented the dynamic approach that I mentioned
>> > above. I've instrumented all pointer comparisons/subtractions in an
>> > LLVM compiler pass and used a kernel module that would print a bug
>> > report whenever two pointers with different tags are being
>> > compared/subtracted (ignoring comparisons with NULL pointers and with
>> > pointers obtained by casting an error code to a pointer type). Then I
>> > tried booting the kernel in QEMU and on an Odroid C2 board and I ran
>> > syzkaller overnight.
>> >
>> > This yielded the following results.
>> >
>> > ======
>> >
>> > The two places that look interesting are:
>> >
>> > is_vmalloc_addr in include/linux/mm.h (already mentioned by Catalin)
>> > is_kernel_rodata in mm/util.c
>> >
>> > Here we compare a pointer with some fixed untagged values to make sure
>> > that the pointer lies in a particular part of the kernel address
>> > space. Since KWHASAN doesn't add tags to pointers that belong to
>> > rodata or vmalloc regions, this should work as is. To make sure I've
>> > added debug checks to those two functions that check that the result
>> > doesn't change whether we operate on pointers with or without
>> > untagging.
>> >
>> > ======
>> >
>> > A few other cases that don't look that interesting:
>> >
>> > Comparing pointers to achieve unique sorting order of pointee objects
>> > (e.g. sorting locks addresses before performing a double lock):
>> >
>> > tty_ldisc_lock_pair_timeout in drivers/tty/tty_ldisc.c
>> > pipe_double_lock in fs/pipe.c
>> > unix_state_double_lock in net/unix/af_unix.c
>> > lock_two_nondirectories in fs/inode.c
>> > mutex_lock_double in kernel/events/core.c
>> >
>> > ep_cmp_ffd in fs/eventpoll.c
>> > fsnotify_compare_groups fs/notify/mark.c
>> >
>> > Nothing needs to be done here, since the tags embedded into pointers
>> > don't change, so the sorting order would still be unique.
>> >
>> > Check that a pointer belongs to some particular allocation:
>> >
>> > is_sibling_entry lib/radix-tree.c
>> > object_is_on_stack in include/linux/sched/task_stack.h
>> >
>> > Nothing needs to be here either, since two pointers can only belong to
>> > the same allocation if they have the same tag.
>> >
>> > ======
>> >
>> > Will, Catalin, WDYT?
>>
>> ping
>
> Thanks for tracking these cases down and going through each of them. The
> obvious follow-up question is: how do we ensure that we keep on top of
> this in mainline? Are you going to repeat your experiment at every kernel
> release or every -rc or something else? I really can't see how we can
> maintain this in the long run, especially given that the coverage we have
> is only dynamic -- do you have an idea of how much coverage you're actually
> getting for, say, a defconfig+modules build?
>
> I'd really like to enable pointer tagging in the kernel, I'm just still
> failing to see how we can do it in a controlled manner where we can reason
> about the semantic changes using something other than a best-effort,
> case-by-case basis which is likely to be fragile and error-prone.
> Unfortunately, if that's all we have, then this gets relegated to a
> debug feature, which sort of defeats the point in my opinion.

Well, in some cases there is no other way as resorting to dynamic testing.
How do we ensure that kernel does not dereference NULL pointers, does
not access objects after free or out of bounds? Nohow. And, yes, it's
constant maintenance burden resolved via dynamic testing.
In some sense HWASAN is better in this regard because it's like, say,
LOCKDEP in this regard. It's enabled only when one does dynamic
testing and collect, analyze and fix everything that pops up. Any
false positives will fail loudly (as opposed to, say, silent memory
corruptions due to use-after-frees), so any false positives will be
just first things to fix during the tool application.
