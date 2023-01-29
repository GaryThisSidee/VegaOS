/*
 *  @description: Some helper c definitions
 *                to make things more readable
 *                and easier to type.
 *
 *  @author(s): Ian Marco Moffett.
 */

#ifndef _SYS_CDEFS_H_
#define _SYS_CDEFS_H_

#define __dead        __attribute__((noreturn))
#define __packed      __attribute__((packed))
#define __naked       __attribute__((naked))
#define __aligned(n)  __attribute__((aligned(n)))
#define __section(s)  __attribute__((section(s)))
#define __malloc      __attribute__((malloc))
#define __asm         __asm__ __volatile__

#ifdef __cplusplus
#define __BEGIN_DECLS extern "C" {
#define __END_DECLS   }
#else
#define __BEGIN_DECLS /* Empty */
#define __END_DECLS   /* Empty */
#endif

#endif
